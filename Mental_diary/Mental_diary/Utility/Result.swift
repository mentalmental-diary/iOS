//
//  Result.swift
//  Study_Room
//
//  Created by Joo Young Kim on 2022/01/28.
//

import Foundation

// Alamofire.Result랑 겹치는 경우가 많아 typealias 선언
public typealias Result = Swift.Result

public extension Result {
    
    var success: Success? {
        switch self {
        case .success(let element): return element
        case .failure: return nil
        }
    }
    
    var error: Error? {
        switch self {
        case .success: return nil
        case .failure(let error): return error
        }
    }
    
    /// 에러 메세지. 에러가 nil이면 앱 공용 기본 에러문구 리턴
    var errorMessage: String {
        return error?.localizedDescription ?? "일시적 오류입니다. 잠시 후 다시 시도해 주세요."
    }
}
