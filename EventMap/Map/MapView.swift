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
                latitudinalMeters: 170,
                longitudinalMeters: 170)),
            interactionModes: [],
            showsUserLocation: true,
            annotationItems: posts) { post in
                MapAnnotation(coordinate: post.getCLLocationCoordinate2D()) {
                    Button {
                        selectedPost = post.id
                    } label: {
                        ZStack {
                            Image(systemName: post.id == selectedPost ? "seal.fill" : "circle.fill")
                                .font(post.id == selectedPost ? .largeTitle : .title)
                                .foregroundColor(post.getHourColor())
                                .shadow(radius: 5)
                            
                            Image(systemName: "mappin")
                                .font(post.id == selectedPost ? .title2 : .title3)
                                .foregroundColor(Color(.systemBackground))
                        }
                    }
                }
            }
        }
        .alert("位置情報が無効です", isPresented: .constant(!viewModel.locationManager.checkAuthorizationStatus())) {
            Button("設定を開く") {
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }
        } message: {
            Text("""
            アプリをを使用するには、位置情報の使用を許可する必要があります。
            設定アプリで位置情報を有効にしてください。
            """)
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
