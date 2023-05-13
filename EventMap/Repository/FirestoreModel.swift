//
//  FirestoreModel.swift
//  EventMap
//
//  https://github.com/RyoDeveloper/EventMap
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import CoreLocation
import FirebaseFirestore
import FirebaseStorage
import Foundation
import UIKit

class FirestoreModel {
    // MARK: Firestore
    
    /// 投稿
    func post(post: Post) async {
        let db = Firestore.firestore()
        do {
            try await db.collection("posts").document(post.id).setData([
                "user_id": post.user_id,
                "title": post.title,
                "image_url": post.image_url.absoluteString,
                "geopoint": post.geopoint,
                "created_at": post.created_at
            ])
        } catch {
            print(error)
        }
    }
    
    /// 取得
    func get(from: CLLocationCoordinate2D) async -> [Post] {
        var posts: [Post] = []
        do {
            let querySnapshot = try await Firestore.firestore().collection("posts").getDocuments()
            for document in querySnapshot.documents {
                let data = document.data()
                let post = Post(user_id: data["user_id"] as? String ?? "",
                                title: data["title"] as? String ?? "",
                                image_url: URL(string: data["image_url"] as! String) ?? URL(string: "NoImage")!,
                                geopoint: data["geopoint"] as? GeoPoint ?? GeoPoint(latitude: 0.0, longitude: 0.0),
                                created_at: data["created_at"] as? Timestamp ?? Timestamp(date: Date()))
                if post.distance(from: from) < 160 {
                    posts.append(post)
                }
            }
        } catch {
            print("error")
        }
        return posts
    }
    
    /// 自分の投稿を取得
    func get(user_id: String) async -> [Post] {
        var posts: [Post] = []
        do {
            let querySnapshot = try await Firestore.firestore().collection("posts")
                .whereField("user_id", isEqualTo: user_id).getDocuments()
            for document in querySnapshot.documents {
                let data = document.data()
                let post = Post(user_id: data["user_id"] as? String ?? "",
                                title: data["title"] as? String ?? "",
                                image_url: URL(string: data["image_url"] as! String) ?? URL(string: "NoImage")!,
                                geopoint: data["geopoint"] as? GeoPoint ?? GeoPoint(latitude: 0.0, longitude: 0.0),
                                created_at: data["created_at"] as? Timestamp ?? Timestamp(date: Date()))
                posts.append(post)
            }
        } catch {
            print("error")
        }
        return posts
    }
    
    // MARK: Firestorage
    
    /// 画像をアップロード
    func uploadImage(image: UIImage) -> URL {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        // 画像の情報
        let imageRef = storageRef.child("post/\(UUID().uuidString).jpg")
        let data = image.jpegData(compressionQuality: 0.5)!
        // タイプを画像に指定
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        var returnURL = URL(string: "NoImage")!
        let semaphore = DispatchSemaphore(value: 0)
        
        // 画像をアップロード
        let uploadTask = imageRef.putData(data, metadata: metadata)
        // 画像のURLを取得
        uploadTask.observe(.success) { _ in
            imageRef.downloadURL { url, error in
                if let url {
                    returnURL = url
                } else if let error {
                    print(error)
                }
                semaphore.signal()
            }
        }
        semaphore.wait()
        return returnURL
    }
}
