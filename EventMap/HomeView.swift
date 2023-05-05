//
//  HomeView.swift
//  EventMap
//
//  https://github.com/RyoDeveloper/EventMap
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = ContentViewModel()

    var body: some View {
        ZStack {
            MapView(posts: $viewModel.posts)
            VStack {
                Spacer()
                PostCarouselView(posts: viewModel.posts)
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
