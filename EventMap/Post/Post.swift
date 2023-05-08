//
//  Post.swift
//  EventMap
//
//  https://github.com/RyoDeveloper/EventMap
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import FirebaseFirestore
import Foundation
import SwiftUI
import CoreLocation

struct Post: Hashable, Identifiable {
    // mapのannotationに表示するために必要(document_idと統合させることも検討)
    var id = UUID()

    var document_id = UUID().uuidString
    var user_id: String
    var title: String
    var image_url: URL
    var geopoint: GeoPoint
    var created_at: Timestamp
    
    /// GeoPointをCLLocationCoordinate2Dに変換して返す
    func getCLLocationCoordinate2D() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: geopoint.latitude, longitude: geopoint.longitude)
    }

    /// 経過時間を返す
    func getHour() -> Double {
        let second = created_at.dateValue().timeIntervalSinceNow
        var hour = second / 3600
        // 経過時間を求めたいため符号を反転
        hour *= -1
        let decimalHour = round(hour * 10) / 10
        return decimalHour
    }

    /// 経過時間から色を返す
    func getHourColor() -> Color {
        let second = created_at.dateValue().timeIntervalSinceNow
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
