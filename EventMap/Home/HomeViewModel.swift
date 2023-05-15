//
//  HomeViewModel.swift
//  EventMap
//
//  https://github.com/RyoDeveloper/EventMap
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import Foundation

class HomeViewModel: ObservableObject {
    private var firestoreModel = FirestoreModel.shared
    private var locationManager = LocationManager.shared
    @Published var posts: [Post] = []
    @Published var selectedPost = ""
    
    /// 取得
    @MainActor
    func get() async {
        posts = await firestoreModel.get(from: locationManager.currentLocation?.coordinate ?? .init(latitude: 0.0, longitude: 0.0))
        
        setSelectedPost()
    }
    
    /// selectedPostの初期値を設定
    func setSelectedPost() {
        selectedPost = posts.first?.id ?? ""
    }
    
    /// updated_atを更新
    func updateUpdatedAt(post: Post) async {
        await firestoreModel.updateUpdatedAt(post: post)
    }
}
