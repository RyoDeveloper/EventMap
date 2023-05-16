//
//  LocationManager.swift
//  EventMap
//
//  https://github.com/RyoDeveloper/EventMap
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import Combine
import CoreLocation
import Foundation

final class LocationManager: NSObject {
    // シングルトン
    public static let shared = LocationManager()
    private let locationManager = CLLocationManager()
    private let locationSubject = PassthroughSubject<[CLLocation], Never>()

    override private init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        // 5mごとに位置情報を取得
        locationManager.distanceFilter = 5
        locationManager.startUpdatingLocation()
    }

    func locationPublisher() -> AnyPublisher<[CLLocation], Never> {
        return locationSubject.eraseToAnyPublisher()
    }

    /// 位置情報の取得許可を確認
    func checkAuthorizationStatus() -> Bool {
        let status = locationManager.authorizationStatus
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        case .notDetermined, .restricted, .denied:
            return false
        @unknown default:
            return false
        }
    }

    /// 現在地を取得の取得
    var currentLocation: CLLocation? {
        return locationManager.location
    }
}

extension LocationManager: CLLocationManagerDelegate {
    // https://developer.apple.com/documentation/corelocation/cllocationmanagerdelegate/1423615-locationmanager
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationSubject.send(locations)
    }
}
