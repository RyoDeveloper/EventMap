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

    var body: some View {
        TabView {
            ForEach(posts, id: \.self) { post in
                VStack(alignment: .leading) {
                    PostView(post: post)
                }
                .background(.regularMaterial)
                .padding()
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
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .frame(height: viewHeight)
    }
}

struct PostCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        PostCarouselView(posts: [Post(user_id: "1", title: "Title1", image_url: URL(string: "NoImage")!, geopoint: GeoPoint(latitude: 0.0, longitude: 0.0)), Post(user_id: "2", title: "Title2", image_url: URL(string: "NoImage")!, geopoint: GeoPoint(latitude: 0.0, longitude: 0.0))])
    }
}
