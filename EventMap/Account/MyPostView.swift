//
//  MyPostView.swift
//  EventMap
//
//  https://github.com/RyoDeveloper/EventMap
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import SwiftUI

struct MyPostView: View {
    @EnvironmentObject var authentication: AuthenticationViewModel
    @StateObject var viewModel = MyPostViewModel()
    let model = FirestoreModel()

    var body: some View {
        List {
            ForEach(viewModel.myPost, id: \.self) { post in
                PostView(post: post)
            }
        }
        .listStyle(.plain)
        .task {
            await viewModel.getMyPost(user_id: authentication.user?.uid ?? "ユーザーなし")
        }
    }
}

struct MyPostView_Previews: PreviewProvider {
    static var previews: some View {
        MyPostView()
            .environmentObject(AuthenticationViewModel())
    }
}
