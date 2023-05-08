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
            annotationItems: posts) { post in
                MapMarker(coordinate: post.getCLLocationCoordinate2D(), tint: post.getHourColor())
            }
        }
        .onAppear {
            viewModel.activate()
        }
        .onDisappear {
            viewModel.cancellables.removeAll()
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(posts: .constant([]))
    }
}
