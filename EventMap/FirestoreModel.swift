//
//  FirestoreModel.swift
//  EventMap
//
//  https://github.com/RyoDeveloper/EventMap
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import Firebase
import Foundation

class FirestoreModel {
    /// 投稿
    func post(post: Post) async {
        let db = Firestore.firestore()
        do {
            try await db.collection("posts").document(post.document_id).setData([
                "user_id": post.user_id,
                "title": post.title,
                "geopoint": post.geopoint
            ])
        } catch {
            print(error)
        }
    }

    /// 取得
    func get() async -> [Post] {
        var posts: [Post] = []
        do {
            let querySnapshot = try await Firestore.firestore().collection("posts").getDocuments()
            for document in querySnapshot.documents {
                let data = document.data()
                let post = Post(user_id: data["user_id"] as? String ?? "",
                                title: data["title"] as? String ?? "",
                                geopoint: data["geopoint"] as? GeoPoint ?? GeoPoint(latitude: 0.0, longitude: 0.0))
                posts.append(post)
            }
        } catch {
            print("error")
        }
        return posts
    }
}
