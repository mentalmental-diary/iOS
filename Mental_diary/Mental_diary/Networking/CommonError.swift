//
//  CommonError.swift
//  Study_Room
//
//  Created by JooYoung Kim on 2022/01/27.
//

import Foundation

/// 앱 전반에서 간단히 에러문구 생성할 때 사용하는 custom error enum
public enum CommonError: Error, LocalizedError {
    
    case unknown
    case notLoggedIn
    case missingToken
    case unauthorized // 라이브 권한없음
    case underDevelopment
    
    case invalidUrl
    case invalidResponse
    
    case missingInfo
    case notSupportedFilter
    
    case timeout
    case offline
    case failedToFetch
    case failedToApply
    
    /// 서버 API에서 의도적으로 내려주는 에러 코드와 메세지
    case server(Int?, String)
    
    case custom(String)
    
    public var errorDescription: String? {
        switch self {
        case .unknown:          return "unknown"
        case .notLoggedIn:      return "Not logged in"
        case .missingToken:     return "No Token Exist"
        case .unauthorized:     return "권한 없음"
        case .underDevelopment: return "Under Development"
            
        case .invalidUrl:       return "Invalid URL"
        case .invalidResponse:  return "Invalid API Response"
            
        case .missingInfo:        return "Required Information missing"
        case .notSupportedFilter: return "Not supported filter"
            
        case .timeout:       return "타임아웃"
        case .offline:       return "오프라인"
        case .failedToFetch:    return "일시적인 오류로 서비스에 접속 할 수 없습니다."
        case .failedToApply:    return "일시적 오류입니다. 잠시 후 다시 시도해 주세요."
            
        case .server(_, let message): return message
        case .custom(let message): return message
        }
    }
}

extension Error {
    
    public var code: Int { return (self as NSError).code }
    
    public var timeout: Bool {
        guard let commonError = self as? CommonError else {
            return code == NSURLErrorTimedOut
        }
        
        switch commonError {
        case CommonError.timeout: return true
        default: return false
        }
    }
}

public extension Int {
    
    /// offline 에러코드인지 판단한다
    var isOfflineErrorCode: Bool {
        return [NSURLErrorNotConnectedToInternet, NSURLErrorDataNotAllowed].contains(self)
    }
}
