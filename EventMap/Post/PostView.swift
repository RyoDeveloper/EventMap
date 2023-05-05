//
//  PostView.swift
//  EventMap
//
//  https://github.com/RyoDeveloper/EventMap
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import Firebase
import SwiftUI

struct PostView: View {
    let post: Post

    var body: some View {
        VStack(alignment: .leading) {
            Text(post.title)
            Text("\(post.geopoint.latitude.description)N, \(post.geopoint.longitude.description)E")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(post: Post(user_id: "1", title: "Title1", geopoint: GeoPoint(latitude: 0.0, longitude: 0.0)))
    }
}
