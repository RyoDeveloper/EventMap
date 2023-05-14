//
//  PostView.swift
//  EventMap
//
//  https://github.com/RyoDeveloper/EventMap
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import CoreLocation
import FirebaseFirestore
import SwiftUI

struct PostView: View {
    var viewModel = PostViewModel()
    let post: Post
    
    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: post.image_url) { Image in
                Image
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.height / 7, height: UIScreen.main.bounds.height / 7)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } placeholder: {
                ProgressView()
                    .frame(width: UIScreen.main.bounds.height / 7, height: UIScreen.main.bounds.height / 7)
            }
            
            VStack(alignment: .leading) {
                Text(post.title)
                    .font(.headline)
                
                Spacer()
                
                Text(String(format: "%.1f", post.distance(from: viewModel.locationManager.currentLocation?.coordinate ?? CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0))) + "m")
                
                Spacer()
                
                Text(String(format: "%.1f", post.getHour()) + "時間前")
                    .font(.caption)
                
                Spacer()
                
                Button("Mapを開く") {
                    let application = UIApplication.shared
                    let url = viewModel.getMapURL(geopoint: post.geopoint, title: post.title)
                    application.open(url)
                }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height / 7, alignment: .leading)
        .padding()
        .background {
            LinearGradient(colors: [post.getHourColor(), .clear, .clear, .clear], startPoint: .leading, endPoint: .trailing)
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(post: Post(user_id: "1", title: "Title1", image_url: URL(string: "NoImage")!, geopoint: GeoPoint(latitude: 0.0, longitude: 0.0), created_at: Timestamp(date: Date())))
    }
}
