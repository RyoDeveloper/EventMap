//
//  PostComposeViewModel.swift
//  EventMap
//
//  https://github.com/RyoDeveloper/EventMap
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import Firebase
import Foundation

class PostComposeViewModel: ObservableObject {
    var firestoreModel = FirestoreModel()
    @Published var title = ""

    func post(user_id: String) async {
        await firestoreModel.post(post: Post(user_id: user_id, title: title, geopoint: GeoPoint(latitude: 0.0, longitude: 0.0)))
    }
}
