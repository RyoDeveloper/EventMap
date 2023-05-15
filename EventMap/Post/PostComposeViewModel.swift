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
    private var firestoreModel = FirestoreModel.shared
    private var locationManager = LocationManager.shared
    @Published var title = ""
    @Published var image: UIImage?

    func post(user_id: String) async {
        guard let image = image else {
            return
        }
        let imageURL = firestoreModel.uploadImage(image: image)
        guard let location = locationManager.currentLocation?.coordinate else {
            return
        }
        await firestoreModel.post(post: Post(user_id: user_id, title: title, image_url: imageURL, geopoint: GeoPoint(latitude: location.latitude, longitude: location.longitude), created_at: Timestamp(date: Date())))
    }
}
