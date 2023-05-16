//
//  Post.swift
//  EventMap
//
//  https://github.com/RyoDeveloper/EventMap
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import CoreLocation
import FirebaseFirestore
import Foundation
import SwiftUI

struct Post: Hashable, Identifiable {
    var id: String = UUID().uuidString
    var user_id: String
    var title: String
    var image_url: URL
    var geopoint: GeoPoint
    var created_at: Timestamp
    var updated_at: Timestamp
    /// GeoPointをCLLocationCoordinate2Dに変換して返す
    var locationCoordinate2D: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: geopoint.latitude, longitude: geopoint.longitude)
    }
    
    /// 2点間の距離を返す(m)
    func distance(from coordinate: CLLocationCoordinate2D) -> CLLocationDistance {
        let from = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let to = CLLocation(latitude: locationCoordinate2D.latitude, longitude: locationCoordinate2D.longitude)
        let distance = from.distance(from: to)
        let decimalLocation = round(distance * 10) / 10
        return decimalLocation
    }
    
    /// 経過時間を返す
    func getHour() -> Double {
        let second = updated_at.dateValue().timeIntervalSinceNow
        var hour = second / 3600
        // 経過時間を求めたいため符号を反転
        hour *= -1
        let decimalHour = round(hour * 10) / 10
        return decimalHour
    }
    
    /// 経過時間から色を返す
    func getHourColor() -> Color {
        let second = updated_at.dateValue().timeIntervalSinceNow
        let hour = second / 3600
        
        if hour >= -1 {
            return .red
        } else if hour >= -6 {
            return .green
        } else if hour >= -12 {
            return .blue
        } else {
            return .gray
        }
    }
}
