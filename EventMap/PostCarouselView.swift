//
//  PostCarouselView.swift
//  EventMap
//
//  https://github.com/RyoDeveloper/EventMap
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import Firebase
import SwiftUI

struct PostCarouselView: View {
    var posts: [Post]

    var body: some View {
        TabView {
            ForEach(posts, id: \.self) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                    Text("\(post.geopoint.latitude.description)N, \(post.geopoint.longitude.description)E")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
                .background(.regularMaterial)
                .padding()
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}

struct PostCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        PostCarouselView(posts: [Post(user_id: "1", title: "Title1", geopoint: GeoPoint(latitude: 0.0, longitude: 0.0)), Post(user_id: "2", title: "Title2", geopoint: GeoPoint(latitude: 0.0, longitude: 0.0))])
    }
}
