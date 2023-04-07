//
//  Alert.swift
//  Study_Room
//
//  Created by Joo Young Kim on 2022/02/05.
//

import SwiftUI
import SwifterSwift

/// CustomAlert를 위한 View
struct Alert: View {
    var body: some View {
        HStack {
            Text("Alert")
            
            Button("test", action: {
                print("Asd")
            })
        }
    }
}

struct Alert_Previews: PreviewProvider {
    static var previews: some View {
        Alert()
    }
}
