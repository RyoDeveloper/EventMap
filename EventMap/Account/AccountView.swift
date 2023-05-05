//
//  AccountView.swift
//  EventMap
//
//  https://github.com/RyoDeveloper/EventMap
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import SwiftUI

enum accountPage {
    case post
    case setting
}

struct AccountView: View {
    @EnvironmentObject var authentication: AuthenticationViewModel
    @State var selection: accountPage = .post

    var body: some View {
        VStack {
            Label(authentication.user?.uid ?? "ID無し",
                  systemImage: (authentication.user?.uid != nil) ? "apple.logo" : "person.crop.circle.badge.xmark.fill")
                .textSelection(.enabled)
                .frame(maxWidth: .infinity, alignment: .leading)

            Picker("", selection: $selection, content: {
                Text("投稿")
                    .tag(accountPage.post)
                Text("設定")
                    .tag(accountPage.setting)
            })
            .pickerStyle(.segmented)
            Divider()

            switch selection {
            case .post:
                MyPostView()
            case .setting:
                SettingView()
            }
        }
        .padding()
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
            .environmentObject(AuthenticationViewModel())
    }
}
