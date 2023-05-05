//
//  MyPostViewModel.swift
//  EventMap
//
//  https://github.com/RyoDeveloper/EventMap
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import Foundation

class MyPostViewModel: ObservableObject {
    let model = FirestoreModel()
    @Published var myPost: [Post] = []

    @MainActor
    func getMyPost(user_id: String) async {
        myPost = await model.getMyPost(user_id: user_id)
    }
}
