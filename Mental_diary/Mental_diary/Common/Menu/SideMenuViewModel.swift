//
//  SideMenuViewModel.swift
//  Study_Room
//
//  Created by JooYoung Kim on 2022/03/23.
//

import Foundation

class SideMenuViewModel: ObservableObject {
    @Published var isSideMenuShow: Bool = false
}

enum MenuItemEnum: Int, CaseIterable {
    case studyExplore
    case planner
    case profile
    
    var title: String {
        switch self {
        case .studyExplore: return "Messages"
        case .planner: return "Notifications"
        case .profile: return "Profile"
        }
    }
    
    var imageName: String {
        switch self {
        case .studyExplore: return "bubble.left"
        case .planner: return "bell"
        case .profile: return "person"
        }
    }
}
