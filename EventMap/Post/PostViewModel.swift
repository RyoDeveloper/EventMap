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
    var locationManager = LocationManager.shared
    private var notificationModel = NotificationModel.shared

    ///  MapのURLを作成
    func getMapURL(geopoint: GeoPoint, title: String) -> URL {
        let encodeString = title.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
        return URL(string: "http://maps.apple.com/?ll=\(geopoint.latitude),\(geopoint.longitude)&q=\(encodeString ?? "")")!
    }

    /// 通知を送る
    func scheduleNotification(distance: Double) {
        let timeInterval: Double
        if distance * 0.75 < 10 {
            // 最短でも10秒後に送る
            timeInterval = 10
        } else {
            timeInterval = distance
        }
        notificationModel.scheduleNotification(title: "イベントに参加できましたか?", body: "今も開催中であることを共有しよう!", timeInterval: timeInterval)
    }
}
