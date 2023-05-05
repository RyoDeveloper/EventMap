//
//  MapView.swift
//  EventMap
//
//  https://github.com/RyoDeveloper/EventMap
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import MapKit
import SwiftUI

struct MapView: View {
    @StateObject var viewModel = MapViewModel()
    @Binding var posts: [Post]

    var body: some View {
        VStack {
            Map(coordinateRegion: .constant(MKCoordinateRegion(
                center: viewModel.location,
                latitudinalMeters: 50,
                longitudinalMeters: 50)),
            interactionModes: [],
            showsUserLocation: true,
            annotationItems: viewModel.places) { place in
                MapMarker(coordinate: place.location)
            }
        }
        .onAppear {
            viewModel.activate()
            viewModel.changeIdentifiablePlace(posts: posts)
        }
        .onDisappear {
            viewModel.cancellables.removeAll()
        }
        .onChange(of: posts) { newValue in
            viewModel.changeIdentifiablePlace(posts: newValue)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(posts: .constant([]))
    }
}
