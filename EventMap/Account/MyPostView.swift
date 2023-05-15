//
//  MyPostView.swift
//  EventMap
//
//  https://github.com/RyoDeveloper/EventMap
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import SwiftUI

struct MyPostView: View {
    @EnvironmentObject var authentication: AuthenticationModel
    @StateObject private var viewModel = MyPostViewModel()

    var body: some View {
        Group {
            if !viewModel.myPost.isEmpty {
                List {
                    ForEach(viewModel.myPost, id: \.id) { post in
                        PostView(post: post)
                            .cornerRadius(10)
                    }
                }
                .listStyle(.plain)

            } else {
                VStack(spacing: 20) {
                    Image(systemName: "camera")
                        .font(.largeTitle)

                    Text("投稿がありません。")
                        .font(.headline)

                    Text("左上の+ボタンから投稿してください。")
                }
                .frame(maxHeight: .infinity)
            }
        }
        .task {
            await viewModel.getMyPost(user_id: authentication.user?.uid ?? "ユーザーなし")
        }
    }
}

struct MyPostView_Previews: PreviewProvider {
    static var previews: some View {
        MyPostView()
            .environmentObject(AuthenticationModel())
    }
}
