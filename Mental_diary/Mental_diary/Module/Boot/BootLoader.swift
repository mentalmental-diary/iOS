//
//  BootLoader.swift
//  Study_Room
//
//  Created by JooYoung Kim on 2022/01/21.
//

import Foundation

// 각 부트로더 모듈이 상속받을 프로토콜. instance를 생성하지 않고 class func으로 구현한다.
protocol BootLoaderProtocol {
    static func loadModule()
}

class BootLoader {
    private static var shared: BootLoader? = BootLoader()
    private let uiThreadBootLoaderModules: [BootLoaderProtocol.Type]
    
    private init() {
        // 부트로더 모듈 목록
        uiThreadBootLoaderModules = [
            LoggerBootModule.self,
            LoginBootModule.self
        ]
    }
    class func runBootLoaderModules() {
        shared?.runBootLoaderModulesOnInstance()
    }
    
    private func runBootLoaderModulesOnInstance() {
        self.uiThreadBootLoaderModules.forEach { module in
            module.loadModule()
        }
    }
}
