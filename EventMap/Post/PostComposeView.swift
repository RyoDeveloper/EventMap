//
//  PostComposeView.swift
//  EventMap
//
//  https://github.com/RyoDeveloper/EventMap
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import FirebaseFirestore
import SwiftUI

struct PostComposeView: View {
    @EnvironmentObject var authentication: AuthenticationViewModel
    @StateObject var viewModel = PostComposeViewModel()
    // Sheetのフラグ
    @Environment(\.dismiss) var dismiss

    var body: some View {
        List {
            TextField("タイトル(オプション)", text: $viewModel.title)
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("キャンセル", role: .destructive) {
                    dismiss()
                }
                .buttonStyle(.borderless)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("投稿") {
                    Task {
                        await viewModel.post(user_id: authentication.user?.uid ?? "ユーザーなし")
                    }
                    dismiss()
                }
            }
        }
        .navigationTitle("イベントを投稿")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PostComposeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PostComposeView()
        }
    }
}
