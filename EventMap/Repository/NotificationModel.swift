//
//  NotificationModel.swift
//  EventMap
//
//  https://github.com/RyoDeveloper/EventMap
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import Foundation
import UserNotifications

final class NotificationModel {
    
   public static let shared = NotificationModel()
    private init() {
        requestNotification()
    }
    
    /// 通知の許可
    func requestNotification() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { _, error in
            if let error = error {
                print(error)
            }
        }
    }
    
    /// 通知を送る
    func scheduleNotification(title: String, body: String, timeInterval:Double) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}
