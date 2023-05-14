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

    var body: some View {
        ZStack {
            MapView(posts: $viewModel.posts, selectedPost: $viewModel.selectedPost)
            VStack {
                Spacer()
                PostCarouselView(viewModel: viewModel, posts: viewModel.posts, selectedPost: $viewModel.selectedPost)
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
