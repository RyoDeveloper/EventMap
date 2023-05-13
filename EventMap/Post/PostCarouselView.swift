//
//  PostCarouselView.swift
//  EventMap
//
//  https://github.com/RyoDeveloper/EventMap
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import FirebaseFirestore
import SwiftUI

struct PostCarouselView: View {
    var posts: [Post]
    @State private var viewHeight = 0.0
    @Binding var selectedPost: String

    var body: some View {
        TabView(selection: $selectedPost) {
            ForEach(posts, id: \.self) { post in
                PostView(post: post)
                    .background(.regularMaterial)
                    .cornerRadius(10)
                    .padding()
                    .shadow(radius: 5)
                    .background {
                        GeometryReader { geometry in
                            Path { _ in
                                let size = geometry.size.height
                                DispatchQueue.main.async {
                                    if self.viewHeight != size {
                                        self.viewHeight = size
                                    }
                                }
                            }
                        }
                    }
                    .tag(post.id)
            }
        }
        .animation(.default, value: selectedPost)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .frame(height: viewHeight)
    }
}

struct PostCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        PostCarouselView(posts: [Post(user_id: "1", title: "Title1", image_url: URL(string: "NoImage")!, geopoint: GeoPoint(latitude: 0.0, longitude: 0.0), created_at: Timestamp(date: Date())), Post(user_id: "2", title: "Title2", image_url: URL(string: "NoImage")!, geopoint: GeoPoint(latitude: 0.0, longitude: 0.0), created_at: Timestamp(date: Date()))], selectedPost: .constant(""))
    }
}
