//
//  PostComposeViewModel.swift
//  EventMap
//
//  https://github.com/RyoDeveloper/EventMap
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import FirebaseFirestore
import Foundation
import UIKit

class PostComposeViewModel: ObservableObject {
    var firestoreModel = FirestoreModel()
    @Published var title = ""
    @Published var image: UIImage?
    var imageURL: URL = .init(string: "NoImage")!

    func post(user_id: String) async {
        uploadImage()
        await firestoreModel.post(post: Post(user_id: user_id, title: title, image_url: imageURL, geopoint: GeoPoint(latitude: 0.0, longitude: 0.0)))
    }

    func uploadImage() {
        if let image {
            imageURL = firestoreModel.uploadImage(image: image)
        }
    }
}
