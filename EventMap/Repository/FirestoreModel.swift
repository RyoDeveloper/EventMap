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

final class FirestoreModel {
    // シングルトン
    public static let shared = FirestoreModel()
    private init() {}
    private let db = Firestore.firestore()
    private let storage = Storage.storage()
    
    // MARK: Firestore
    
    /// 投稿
    func post(post: Post) async {
        do {
            try await db.collection("posts").document(post.id).setData([
                "user_id": post.user_id,
                "title": post.title,
                "image_url": post.image_url.absoluteString,
                "geopoint": post.geopoint,
                "created_at": post.created_at,
                "updated_at": post.updated_at
            ])
        } catch {
            print(error)
        }
    }
    
    /// 取得
    func get(from: CLLocationCoordinate2D) async -> [Post] {
        var posts: [Post] = []
        do {
            let querySnapshot = try await db.collection("posts")
                .whereField("created_at", isGreaterThanOrEqualTo: Timestamp(date: Date().addingTimeInterval(-60 * 60 * 24)))
                // TODO: 160m以内の投稿を取得するようにする
                .getDocuments()
            
            for document in querySnapshot.documents {
                let data = document.data()
                let post = Post(id: document.documentID,
                                user_id: data["user_id"] as? String ?? "",
                                title: data["title"] as? String ?? "",
                                image_url: URL(string: data["image_url"] as! String) ?? URL(string: "NoImage")!,
                                geopoint: data["geopoint"] as? GeoPoint ?? GeoPoint(latitude: 0.0, longitude: 0.0),
                                created_at: data["created_at"] as? Timestamp ?? Timestamp(date: Date()),
                                updated_at: data["updated_at"] as? Timestamp ?? Timestamp(date: Date()))
                if post.distance(from: from) < 160 {
                    posts.append(post)
                }
            }
        } catch {
            print("error")
        }
        // 距離順に並び替える
        posts.sort { $0.distance(from: from) < $1.distance(from: from) }
        return posts
    }
    
    /// 自分の投稿を取得
    func get(user_id: String) async -> [Post] {
        var posts: [Post] = []
        do {
            let querySnapshot = try await db.collection("posts")
                .whereField("user_id", isEqualTo: user_id).getDocuments()
            for document in querySnapshot.documents {
                let data = document.data()
                let post = Post(id: document.documentID,
                                user_id: data["user_id"] as? String ?? "",
                                title: data["title"] as? String ?? "",
                                image_url: URL(string: data["image_url"] as! String) ?? URL(string: "NoImage")!,
                                geopoint: data["geopoint"] as? GeoPoint ?? GeoPoint(latitude: 0.0, longitude: 0.0),
                                created_at: data["created_at"] as? Timestamp ?? Timestamp(date: Date()),
                                updated_at: data["updated_at"] as? Timestamp ?? Timestamp(date: Date()))
                posts.append(post)
            }
        } catch {
            print("error")
        }
        // 投稿日順に並び替える
        posts.sort { $0.created_at.dateValue() > $1.created_at.dateValue() }
        return posts
    }
    
    /// updated_atを更新
    func updateUpdatedAt(post: Post) async {
        do {
            try await db.collection("posts").document(post.id).updateData(["updated_at": Timestamp(date: Date())])
        } catch {
            print(error)
        }
    }
    
    // MARK: Firestorage
    
    /// 画像をアップロード
    func uploadImage(image: UIImage) -> URL {
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
