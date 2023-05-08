//
//  HomeView.swift
//  EventMap
//
//  https://github.com/RyoDeveloper/EventMap
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    @State var selectedPost = ""

    var body: some View {
        ZStack {
            MapView(posts: $viewModel.posts, selectedPost: $selectedPost)
            VStack {
                Spacer()
                PostCarouselView(posts: viewModel.posts, selectedPost: $selectedPost)
                    .padding(.bottom)
            }
        }
        .task {
            await viewModel.get()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
