//
//  LoginView.swift
//  EventMap
//
//  https://github.com/RyoDeveloper/EventMap
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import AuthenticationServices
import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 20) {
            Text("EventMap")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 50) {
                Label {
                    Text("徒歩2分以内のイベントを探す")
                        .font(.title2)
                } icon: {
                    ZStack {
                        Image(systemName: "seal.fill")
                            .foregroundColor(Color.red)
                            .font(.largeTitle)
                        Text("1")
                            .foregroundColor(Color(.systemBackground))
                    }
                }
                
                Label {
                    Text("イベントに参加")
                } icon: {
                    ZStack {
                        Image(systemName: "seal.fill")
                            .foregroundColor(Color.green)
                            .font(.largeTitle)
                        Text("2")
                            .foregroundColor(Color(.systemBackground))
                    }
                }
                
                Label {
                    Text("参加中のイベントを投稿")
                } icon: {
                    ZStack {
                        Image(systemName: "seal.fill")
                            .foregroundColor(Color.blue)
                            .font(.largeTitle)
                        Text("3")
                            .foregroundColor(Color(.systemBackground))
                    }
                }
            }
            .font(.title2)
            
            Spacer()
            
            SignInWithAppleButton(.signIn) { request in
                viewModel.handleSignInWithAppleRequest(request)
            } onCompletion: { result in
                viewModel.handleSignInWithAppleCompletion(result)
            }
            .signInWithAppleButtonStyle(colorScheme == .light ? .black : .white)
            .frame(height: 50.0)
            
            Divider()
            
            NavigationLink {
                HomeView()
                    .edgesIgnoringSafeArea(.bottom)
                    .navigationBarTitleDisplayMode(.inline)
            } label: {
                Label("サインインせずに試す", systemImage: "person.fill")
                    .fontWeight(.semibold)
                    .foregroundColor(Color(.systemBackground))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.primary)
                    .cornerRadius(6)
            }
            
            Text("イベントを探す機能のみ、一時的に試すことができます。")
                .foregroundColor(Color(.secondaryLabel))
                .lineLimit(1)
                .minimumScaleFactor(0.1)
        }
        .padding()
        .navigationTitle("サインインする")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(true)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LoginView()
                .environmentObject(AuthenticationViewModel())
        }
    }
}
