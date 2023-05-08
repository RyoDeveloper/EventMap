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
    @Binding var selectedPost: String
    
    var body: some View {
        VStack {
            Map(coordinateRegion: .constant(MKCoordinateRegion(
                center: viewModel.location,
                latitudinalMeters: 50,
                longitudinalMeters: 50)),
            interactionModes: [],
            showsUserLocation: true,
            annotationItems: posts) { post in
                MapAnnotation(coordinate: post.getCLLocationCoordinate2D()) {
                    Button {
                        selectedPost = post.document_id
                    } label: {
                        ZStack {
                            Image(systemName: post.document_id == selectedPost ? "seal.fill" : "circle.fill")
                                .font(post.document_id == selectedPost ? .largeTitle : .title)
                                .foregroundColor(post.getHourColor())
                                .shadow(radius: 5)
                            
                            Image(systemName: "mappin")
                                .font(post.document_id == selectedPost ? .title2 : .title3)
                                .foregroundColor(Color(.systemBackground))
                        }
                    }
                }
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
        MapView(posts: .constant([]), selectedPost: .constant(""))
    }
}
