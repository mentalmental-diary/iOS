//
//  MenuDetailView.swift
//  Study_Room
//
//  Created by JooYoung Kim on 2022/03/21.
//

import SwiftUI

struct MenuDetailView: View {
    let sideMenuItem: MenuItemEnum
    
    var body: some View {
        HStack {
            Image(systemName: sideMenuItem.imageName)
             .frame(width: 24, height: 24, alignment: .center)
            Spacer()
                .frame(width: 10, height: 0, alignment: .center)
            Text(sideMenuItem.title).bold()
            Spacer()
        }
        .foregroundColor(.white)
    }
}

struct MenuDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MenuDetailView(sideMenuItem: .profile)
    }
}
