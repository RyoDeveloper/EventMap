//
//  ContentView.swift
//  EventMap
//
//  https://github.com/RyoDeveloper/EventMap
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import SwiftUI

enum ContentPage {
    case home
    case account
}

struct ContentView: View {
    @EnvironmentObject var authentication: AuthenticationModel
    @State var selection: ContentPage = .home
    @State var isShowPostComposeView = false

    var body: some View {
        NavigationStack {
            TabView(selection: $selection) {
                HomeView()
                    .tabItem {
                        Label("ホーム", systemImage: "house.fill")
                    }
                    .tag(ContentPage.home)
                AccountView()
                    .environmentObject(authentication)
                    .tabItem {
                        Label("アカウント", systemImage: "person.fill")
                    }
                    .tag(ContentPage.account)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowPostComposeView = true
                    } label: {
                        Label("投稿", systemImage: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $isShowPostComposeView) {
            NavigationStack {
                PostComposeView()
            }
        }
        .navigationTitle(selection == .home ? "ホーム" : "アカウント")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ContentView()
        }
    }
}
