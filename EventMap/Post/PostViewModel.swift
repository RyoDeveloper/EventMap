//
//  PostViewModel.swift
//  EventMap
//
//  https://github.com/RyoDeveloper/EventMap
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import FirebaseFirestore
import Foundation

class PostViewModel {
    var locationManager = LocationManager()

    ///  MapのURLを作成
    func getMapURL(geopoint: GeoPoint, title: String) -> URL {
        let encodeString = title.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
        return URL(string: "http://maps.apple.com/?ll=\(geopoint.latitude),\(geopoint.longitude)&q=\(encodeString ?? "")")!
    }
}
