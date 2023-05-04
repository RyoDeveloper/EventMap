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
    @State var selection: accountPage = .post

    var body: some View {
        VStack {
            Picker("", selection: $selection, content: {
                Text("投稿")
                    .tag(accountPage.post)
                Text("設定")
                    .tag(accountPage.setting)
            })
            .pickerStyle(.segmented)
            .padding()

            switch selection {
            case .post:
                ScrollView {
                    Text("投稿")
                }
            case .setting:
                SettingView()
            }
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
