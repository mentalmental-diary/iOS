//
//  LoggerEnum.swift
//  Study_Room
//
//  Created by JooYoung Kim on 2022/01/21.
//

import Foundation

public enum ErrorType: String {
    
    // MARK: 기능별
    case logic
    case login
    case configuration
    case notification
    case scheme
    case photoInfraThumbnail
    case lynk
    case cloudkit
    case realmdb
    case memoryWarning
    case webview
    case nclicks
    case hardware
    case alert
    
    // MARK: API
    case apiFail
}
