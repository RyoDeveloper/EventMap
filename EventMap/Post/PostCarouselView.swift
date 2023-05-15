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
    @StateObject var viewModel: HomeViewModel
    var posts: [Post]
    @State private var viewHeight = 1.0
    @Binding var selectedPost: String

    var body: some View {
        if !posts.isEmpty {
            TabView(selection: $selectedPost) {
                ForEach(posts, id: \.id) { post in
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
                        .contextMenu {
                            Button {
                                Task {
                                    await viewModel.updateUpdatedAt(post: post)
                                }
                            } label: {
                                Label("今も開催中", systemImage: "clock")
                            }
                        }
                }
            }
            .animation(.default, value: selectedPost)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: viewHeight)
        } else {
            VStack(alignment: .leading) {
                Text("この場所には投稿がありません。")
                    .font(.headline)

                Text("場所を変えて再更新してください。")

                Button("再更新する") {
                    Task {
                        await viewModel.get()
                    }
                }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.regularMaterial)
            .cornerRadius(10)
            .padding()
            .shadow(radius: 5)
        }
    }
}

struct PostCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        PostCarouselView(viewModel: HomeViewModel(), posts: [Post(user_id: "1", title: "Title1", image_url: URL(string: "NoImage")!, geopoint: GeoPoint(latitude: 0.0, longitude: 0.0), created_at: Timestamp(date: Date()), updated_at: Timestamp(date: Date())), Post(user_id: "2", title: "Title2", image_url: URL(string: "NoImage")!, geopoint: GeoPoint(latitude: 0.0, longitude: 0.0), created_at: Timestamp(date: Date()), updated_at: Timestamp(date: Date()))], selectedPost: .constant(""))
    }
}
