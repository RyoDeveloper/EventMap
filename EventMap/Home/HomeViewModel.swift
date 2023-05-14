//
//  HomeViewModel.swift
//  EventMap
//
//  https://github.com/RyoDeveloper/EventMap
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import Foundation

class HomeViewModel: ObservableObject {
    var firestoreModel = FirestoreModel()
    var locationManager = LocationManager()
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
}
