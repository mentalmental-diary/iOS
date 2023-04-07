//
//  View+Extension.swift
//  Study_Room
//
//  Created by Joo Young Kim on 2022/01/22.
//

import SwiftUI

/// Modifier 사용
extension View {
    func showIf(condition: Bool) -> AnyView {
        if condition {
            return AnyView(self)
        } else {
            return AnyView(EmptyView())
        }
    }
    
    func toast(message: String, isShowing: Binding<Bool>) -> some View {
        self.modifier(ToastModifier(message: message, isShowing: isShowing))
    }
}

/// ViewBuilder
extension View {
    /// view custom hidden
    @ViewBuilder func visibility(_ visibility: Bool) -> some View {
        if visibility {
            self
        } else {
            hidden()
        }
    }
}
