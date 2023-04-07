//
//  ToastView.swift
//  Study_Room
//
//  Created by JooYoung Kim on 2022/05/12.
//

import SwiftUI

struct ToastView: View {
    var message: String = ""
    @Binding var isShowing: Bool
    var body: some View {
        VStack {
            Spacer()
            if isShowing {
                Group {
                    Text(message)
                        .frame(maxWidth: .infinity)
                        .padding(EdgeInsets.init(top: 10.0, leading: 0.0, bottom: 10.0, trailing: 0.0))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.white)
                        .background(Color.black)
                        .cornerRadius(8)
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        isShowing = false
                    }
                }
            }
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 18)
        .animation(.linear(duration: 0.3), value: isShowing)
        .transition(.opacity)
    }
}

struct ToastModifier: ViewModifier {
    var message: String
    @Binding var isShowing: Bool
    func body(content: Content) -> some View {
        ZStack {
            content
            ToastView(message: message, isShowing: $isShowing)
        }
    }
}

struct ToastView_Previews: PreviewProvider {
    static var previews: some View {
        ToastView(message: "Toast메시지 테스트", isShowing: .constant(true))
    }
}
