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

class LocationManager: NSObject {
    let locationManager = CLLocationManager()
    let locationSubject = PassthroughSubject<[CLLocation], Never>()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationPublisher() -> AnyPublisher<[CLLocation], Never> {
        return locationSubject.eraseToAnyPublisher()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    // https://developer.apple.com/documentation/corelocation/cllocationmanagerdelegate/1423615-locationmanager
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationSubject.send(locations)
    }
}
