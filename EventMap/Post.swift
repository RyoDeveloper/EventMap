//
//  Post.swift
//  EventMap
//
//  https://github.com/RyoDeveloper/EventMap
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import Firebase
import Foundation

struct Post: Hashable {
    var document_id = UUID().uuidString
    var user_id: String
    var title: String
    var geopoint: GeoPoint
}
