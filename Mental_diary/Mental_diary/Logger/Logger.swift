//
//  Logger.swift
//  Study_Room
//
//  Created by JooYoung Kim on 2022/01/19.
//

import Foundation
import CleanroomLogger

public func log(severity: LogSeverity, msg: String, function: String = #function, filePath: String = #file, fileLine: Int = #line, errorType: ErrorType? = nil, errorCode: Int? = nil) {
    cleanRoomLogWrapper(severity: severity, message: msg, function: function, filePath: filePath, fileLine: fileLine, errorType: errorType, errorCode: errorCode)
}

public func debugLog(_ msg: String, function: String = #function, filePath: String = #file, fileLine: Int = #line, errorType: ErrorType? = nil, errorCode: Int? = nil) {
    cleanRoomLogWrapper(severity: .debug, message: msg, function: function, filePath: filePath, fileLine: fileLine, errorType: errorType, errorCode: errorCode)
}

public func infoLog(_ msg: String, function: String = #function, filePath: String = #file, fileLine: Int = #line, errorType: ErrorType? = nil, errorCode: Int? = nil) {
    cleanRoomLogWrapper(severity: .info, message: msg, function: function, filePath: filePath, fileLine: fileLine, errorType: errorType, errorCode: errorCode)
}

public func warningLog(_ msg: String, function: String = #function, filePath: String = #file, fileLine: Int = #line, errorType: ErrorType? = nil, errorCode: Int? = nil) {
    cleanRoomLogWrapper(severity: .warning, message: msg, function: function, filePath: filePath, fileLine: fileLine, errorType: errorType, errorCode: errorCode)
}

public func errorLog(_ msg: String, function: String = #function, filePath: String = #file, fileLine: Int = #line, errorType: ErrorType? = nil, errorCode: Int? = nil) {
    cleanRoomLogWrapper(severity: .error, message: msg, function: function, filePath: filePath, fileLine: fileLine, errorType: errorType, errorCode: errorCode)
}

public func apiLog(_ msg: String, function: String = #function, filePath: String = #file, fileLine: Int = #line, errorType: ErrorType? = .apiFail, errorCode: Int? = nil) {
    let severity: LogSeverity = {
        if errorType == .apiFail { return .error }
        guard let errorCode = errorCode else { return .warning }
        return NSError.networkErrorCodes.contains(errorCode) ? .debug : .warning
    }()
    
    cleanRoomLogWrapper(severity: severity, message: msg, function: function, filePath: filePath, fileLine: fileLine, errorType: errorType, errorCode: errorCode)
}

private func cleanRoomLogWrapper(severity: LogSeverity, message: String, function: String = #function, filePath: String = #file, fileLine: Int = #line, errorType: ErrorType? = nil, errorCode: Int? = nil) {
    
    if let errorType = errorType {
        Log.channel(severity: severity)?.message(message, function: function, filePath: filePath, fileLine: fileLine, errorType: errorType.rawValue, errorCode: errorCode)
    } else {
        Log.channel(severity: severity)?.message(message, function: function, filePath: filePath, fileLine: fileLine)
    }
}

extension NSError {
    
    fileprivate static var networkErrorCodes: [Int] {
        [NSURLErrorTimedOut, NSURLErrorNetworkConnectionLost, NSURLErrorNotConnectedToInternet, NSURLErrorCancelled, NSURLErrorDataNotAllowed]
    }
}
