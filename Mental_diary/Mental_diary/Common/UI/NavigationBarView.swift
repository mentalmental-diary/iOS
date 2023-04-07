//
//  NavigationBarView.swift
//  Study_Room
//
//  Created by JooYoung Kim on 2022/03/28.
//

import SwiftUI

/// 공통으로 사용하게 될 네비게이션 Bar base View -> 향후엔 이미지좀 바꿔두자
struct NavigationBarView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var isShow: Bool
    
    /// 헤더 타이틀
    var title: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            Button(action: {
                withAnimation {
                    isShow = false
                    presentationMode.wrappedValue.dismiss()
                }
            }, label: {
                Image("iconHeaderBackB")
                    .frame(maxHeight: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 0.0, leading: 13.0, bottom: 2.0, trailing: 16.0))
            })
            HStack(spacing: 0) {
                Spacer()
                Text(title)
                    .kerning(0.0)
                    .foregroundColor(Color.black)
                    .font(.custom("AppleSDGothicNeo-SemiBold", size: 18))
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct NavigationViewModifier: ViewModifier {
    private let height: CGFloat = 54.0
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: height, alignment: .leading)
            .overlay(Rectangle()
                        .frame(width: nil, height: 1, alignment: .bottom)
                        .foregroundColor(Color.black.opacity(0.07)),
                     alignment: .bottom)
    }
}

struct NavigationBarView_Previews: PreviewProvider {
    @Environment(\.presentationMode) static var presentationMode: Binding<PresentationMode>
    
    static var previews: some View {
        GeometryReader { proxy in
            VStack(alignment: .leading) {
                NavigationBarView(isShow: .constant(false), title: "알림")
            }
            .frame(width: proxy.size.width, alignment: .leading)
        }
        .previewLayout(.fixed(width: 375.0, height: 54.0))
    }
}
