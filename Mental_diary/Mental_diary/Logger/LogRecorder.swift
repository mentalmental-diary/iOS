//
//  LogRecoder.swift
//  Study_Room
//
//  Created by JooYoung Kim on 2022/01/21.
//

import Foundation
import CleanroomLogger

private typealias ErrorInfo = (errorType: String?, errorCode: String?)

open class ConsoleLogRecorder: StandardStreamsLogRecorder {
    
    /// 콘솔에 로그를 출력하는 Log Configuration을 생성한다.
    /// - Parameter minimumSeverity: 로그 최소레벨. verbose < debug < info < warning < error 순서
    /// - Returns: 'LogConfiguration' instance
    public class func configuration(minimumSeverity: LogSeverity) -> LogConfiguration {
        return BasicLogConfiguration(minimumSeverity: minimumSeverity, recorders: [ConsoleLogRecorder(formatters: [logFormatter])])
    }
    
    override public func record(message: String, for entry: LogEntry, currentQueue: DispatchQueue, synchronousMode: Bool) {
        // Nelo용으로 붙여둔 에러코드값 제거하고 로그 출력
        let messageInfo = message.disassembled
        
        super.record(message: messageInfo?.message ?? message, for: entry, currentQueue: currentQueue, synchronousMode: synchronousMode)
    }
    
    private class var logFormatter: LogFormatter {
        return FieldBasedLogFormatter(fields: [
            .timestamp(.custom("HH:mm:ss.SSS")),
            .literal(" | "),
            .callSite,
            .severity(.custom(textRepresentation: .colorCoded, truncateAtWidth: nil, padToWidth: 2, rightAlign: true)),
            .literal(" : "),
            .payload
        ])
    }
}

extension LogChannel {
    
    /// 에러타입이 추가된 로그 메세지를 남긴다.
    func message(_ msg: String, function: String = #function, filePath: String = #file, fileLine: Int = #line, errorType: String, errorCode: Int?) {
        let msgWithErrCode = msg.append(errorType: errorType, errorCode: errorCode)
        
        message(msgWithErrCode, function: function, filePath: filePath, fileLine: fileLine)
    }
}

extension String {
    
    private var messageDivider: String { return "__errordivider__" }
    private var errorDivider: String { return "_" }
    
    // {스트링}__errordivider__{에러타입}_{에러코드}
    fileprivate func append(errorType: String, errorCode: Int? = nil) -> String {
        let message = self + messageDivider + errorType
        
        guard let errorCode = errorCode else { return message }
        
        return message + errorDivider + String(errorCode)
    }
    
    // 스트링과 에러코드를 분리
    fileprivate var disassembled: (message: String, errorInfo: ErrorInfo)? {
        guard contains(messageDivider) else { return nil }
        
        let array = components(separatedBy: messageDivider)
        let errorComponents = array.last?.components(separatedBy: errorDivider)
        
        let message = array.first ?? self
        let errorType = errorComponents?.first
        let errorCode = (errorComponents?.count ?? 0) > 1 ? errorComponents?.last : nil
        
        return (message, (errorType, errorCode))
    }
}
