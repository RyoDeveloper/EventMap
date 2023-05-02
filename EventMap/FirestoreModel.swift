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
}
