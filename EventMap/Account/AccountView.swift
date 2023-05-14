//
//  AccountView.swift
//  EventMap
//
//  https://github.com/RyoDeveloper/EventMap
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import SwiftUI

enum AccountPage {
    case post
    case setting
}

struct AccountView: View {
    @EnvironmentObject var authentication: AuthenticationModel
    @State var selection: AccountPage = .post

    var body: some View {
        VStack {
            VStack {
                Label(authentication.user?.uid ?? "ID無し",
                      systemImage: (authentication.user?.uid != nil) ? "apple.logo" : "person.crop.circle.badge.xmark.fill")
                    .textSelection(.enabled)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Picker("", selection: $selection, content: {
                    Text("投稿")
                        .tag(AccountPage.post)
                    Text("設定")
                        .tag(AccountPage.setting)
                })
                .pickerStyle(.segmented)
            }
            .padding([.top, .leading, .trailing])
            Divider()
            switch selection {
            case .post:
                MyPostView()
            case .setting:
                SettingView()
            }
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
            .environmentObject(AuthenticationModel())
    }
}
