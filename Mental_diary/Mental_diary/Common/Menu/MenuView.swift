//
//  MenuView.swift
//  Study_Room
//
//  Created by Joo Young Kim on 2022/03/18.
//
// side menu용으로 일단 임시로 만들어두기

import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(MenuItemEnum.allCases, id: \.self) { item in
                NavigationLink {
                    Text(item.title)
                } label: {
                    MenuDetailView(sideMenuItem: item)
                }
            }
            .padding(.leading)
            Spacer()
        }
        .offset(x: 0, y: 50)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .background(Color(red: 32/255, green: 32/255, blue: 32/255))
        .edgesIgnoringSafeArea(.all)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
