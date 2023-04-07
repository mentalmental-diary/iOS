//
//  LoginView.swift
//  Study_Room
//
//  Created by Joo Young Kim on 2022/01/22.
//

import SwiftUI
import NaverThirdPartyLogin
import UIKit
import RxSwift

struct LoginView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var currentUser: UserModel
    
    @ObservedObject private var viewModel: LoginViewModel = LoginViewModel()
    
    var body: some View {
        VStack {
            NavigationBarView(title: "로그인")
                .frame(height: 54)
                .frame(maxWidth: .infinity)
            Spacer()
            HStack {
                Image(systemName: "envelope")
                    .frame(width: 50.0, height: 50.0)
                TextField("ID / Email", text: $viewModel.userEmail)
                    .frame(width: 100.0, height: 10.0)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).strokeBorder())
            }
            HStack {
                Image(systemName: "lock").frame(width: 50.0, height: 50.0)
                SecureField("Password", text: $viewModel.userPassword)
                    .frame(width: 100.0, height: 10.0)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).strokeBorder())
            }
            
            loginAction()
            Spacer()
            loginAccountManager()
        }
        .toast(message: viewModel.errorMessage?.localizedDescription ?? CommonError.failedToApply.localizedDescription, isShowing: $viewModel.isToastShow)
        .onAppear {
            debugLog("로그인화면 진입")
        }
    }
}

extension LoginView {
    @ViewBuilder func loginAction() -> some View {
        HStack {
            Button(action: {
                viewModel.fetchLoginUser(completion: { result in
                    switch result {
                    case .success(let user):
                        currentUser.setInfo(model: user)
                        currentUser.isLogin = true
                        presentationMode.wrappedValue.dismiss()
                    case .failure:
                        viewModel.isToastShow = true
                    }
                })
            }) { // api 호출
                Text("로그인")
                    .frame(width: 80, height: 10)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).strokeBorder())
            }
        }.padding(EdgeInsets.init())
    }
    
    @ViewBuilder func loginAccountManager() -> some View {
        HStack(spacing: 20) {
            Button(action: {}) {
                Text("아이디/비밀번호 찾기")
            }
            Button(action: {}) {
                Text("회원가입")
            }
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    @StateObject static var model: UserModel = UserModel()
    static var previews: some View {
        LoginView()
            .environmentObject(model)
    }
}
