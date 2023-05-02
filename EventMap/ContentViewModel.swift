//
//  ContentViewModel.swift
//  EventMap
//
//  https://github.com/RyoDeveloper/EventMap
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import Foundation

class ContentViewModel: ObservableObject {
    var firestoreModel = FirestoreModel()
    @Published var posts: [Post] = []

    /// 取得
    @MainActor
    func get() async {
        posts = await firestoreModel.get()
    }
}
