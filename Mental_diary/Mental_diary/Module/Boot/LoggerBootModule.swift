//
//  LoggerBootModule.swift
//  Study_Room
//
//  Created by JooYoung Kim on 2022/01/21.
//

import Foundation
import CleanroomLogger

class LoggerBootModule: BootLoaderProtocol {
    
    class func loadModule() {
        Log.enable(configuration: [ConsoleLogRecorder.configuration(minimumSeverity: .debug)])
    }
}
