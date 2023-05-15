//
//  MyPostViewModel.swift
//  EventMap
//
//  https://github.com/RyoDeveloper/EventMap
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import Foundation

class MyPostViewModel: ObservableObject {
    private let firestoreModel = FirestoreModel()
    @Published var myPost: [Post] = []

    @MainActor
    func getMyPost(user_id: String) async {
        myPost = await firestoreModel.get(user_id: user_id)
    }
}
