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
    var model = LocationManager()
    @Published var title = ""
    @Published var image: UIImage?
    var imageURL: URL = .init(string: "NoImage")!

    func post(user_id: String) async {
        uploadImage()
        guard let location = model.currentLocation?.coordinate else {
            return
        }
        await firestoreModel.post(post: Post(user_id: user_id, title: title, image_url: imageURL, geopoint: GeoPoint(latitude: location.latitude, longitude: location.longitude), created_at: Timestamp(date: Date())))
    }

    func uploadImage() {
        if let image {
            imageURL = firestoreModel.uploadImage(image: image)
        }
    }
}
