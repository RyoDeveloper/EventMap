//
//  EventMapApp.swift
//  EventMap
//
//  https://github.com/RyoDeveloper/EventMap
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import FirebaseCore
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct EventMapApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var viewModel = AuthenticationViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                switch viewModel.authenticationState {
                case .authenticated:
                    ContentView()
                        .environmentObject(viewModel)
                default:
                    LoginView()
                        .environmentObject(viewModel)
                }
            }
        }
    }
}
