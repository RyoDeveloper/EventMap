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
    let model = LocationManager()
    var cancellables = Set<AnyCancellable>()
    @Published var location = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)

    func activate() {
        model.locationPublisher().sink { [weak self] locations in
            guard let self = self else {
                return
            }
            if let last = locations.last {
                self.location = last.coordinate
            }
        }.store(in: &cancellables)
    }
}
