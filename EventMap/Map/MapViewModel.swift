//
//  MapViewModel.swift
//  EventMap
//
//  https://github.com/RyoDeveloper/EventMap
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import Combine
import CoreLocation
import Foundation

class MapViewModel: ObservableObject {
    let locationManager = LocationManager.shared
    var cancellables = Set<AnyCancellable>()
    @Published var location: CLLocationCoordinate2D

    init() {
        // 初期値に現在地を設定
        self.location = locationManager.currentLocation?.coordinate ?? CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    }

    func activate() {
        locationManager.locationPublisher().sink { [weak self] locations in
            guard let self = self else {
                return
            }
            if let last = locations.last {
                self.location = last.coordinate
            }
        }.store(in: &cancellables)
    }
}
