//
//  SettingView.swift
//  EventMap
//
//  https://github.com/RyoDeveloper/EventMap
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var authentication: AuthenticationViewModel

    var body: some View {
        List {
            Button("サインアウト", role: .destructive) {
                authentication.signOut()
            }
            Button("アカウントを削除", role: .destructive) {
                Task {
                    await authentication.deleteAccount()
                }
            }
        }
        .listStyle(.plain)
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
            .environmentObject(AuthenticationViewModel())
    }
}
