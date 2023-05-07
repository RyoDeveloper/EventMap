//
//  PostView.swift
//  EventMap
//
//  https://github.com/RyoDeveloper/EventMap
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

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

                Text("\(post.geopoint.latitude.description)N, \(post.geopoint.longitude.description)E")
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
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(post: Post(user_id: "1", title: "Title1", image_url: URL(string: "NoImage")!, geopoint: GeoPoint(latitude: 0.0, longitude: 0.0)))
    }
}