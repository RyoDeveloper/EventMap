//
//  PostComposeView.swift
//  EventMap
//
//  https://github.com/RyoDeveloper/EventMap
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import FirebaseFirestore
import PhotosUI
import SwiftUI

struct PostComposeView: View {
    @EnvironmentObject var authentication: AuthenticationModel
    @StateObject private var viewModel = PostComposeViewModel()
    // Sheetのフラグ
    @Environment(\.dismiss) var dismiss
    @State private var isShowImagePicker = true

    var body: some View {
        VStack {
            Picker("カテゴリー", selection: $viewModel.category) {
                ForEach(Category.allCases, id: \.self) { category in
                    Text(category.rawValue)
                }
            }
            .pickerStyle(.segmented)
            .padding([.top, .leading, .trailing])

            Divider()

            List {
                TextField("タイトル", text: $viewModel.title)
                    .submitLabel(.done)

                if let image = viewModel.image {
                    VStack {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Button("再撮影") {
                            isShowImagePicker = true
                        }
                        .buttonStyle(.borderless)
                    }
                } else {
                    Button("写真撮影") {
                        isShowImagePicker = true
                    }
                }
            }
        }
        .background(Color(.systemGroupedBackground))
        .sheet(isPresented: $isShowImagePicker) {
            ImagePickerView(selectedImage: $viewModel.image)
                .edgesIgnoringSafeArea(.all)
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
                .disabled(viewModel.image == nil || viewModel.title.isEmpty)
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
