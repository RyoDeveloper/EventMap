//
//  Post.swift
//  EventMap
//
//  https://github.com/RyoDeveloper/EventMap
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import FirebaseFirestore
import Foundation

struct Post: Hashable {
    var document_id = UUID().uuidString
    var user_id: String
    var title: String
    var image_url: URL
    var geopoint: GeoPoint
}
