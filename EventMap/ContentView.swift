//
//  ContentView.swift
//  EventMap
//
//  https://github.com/RyoDeveloper/EventMap
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authentication: AuthenticationViewModel
    @StateObject var viewModel = ContentViewModel()

    var body: some View {
        VStack {
            Button("Sign Out") {
                authentication.signOut()
            }
            .buttonStyle(.borderedProminent)

            PostCarouselView(posts: viewModel.posts)
        }
        .task {
            await viewModel.get()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
