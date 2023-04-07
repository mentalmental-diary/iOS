//
//  URLBuilder.swift
//  Study_Room
//
//  Created by JooYoung Kim on 2022/01/25.
//

import Foundation

public class UrlBuilder {
    
    /// 현재 server phase 설정값에 기반한 API 주소를 생성하고 HMAC encryption을 한다.
    ///
    /// - Parameters:
    ///   - relativePath: url string. 스트링 앞에 /가 있던 없던간에 관계없이 동작한다.
    ///   - apiType: 태그검색은 .tagSearch 명시. 미입력시 GP gateway로 동작한다.
    ///   - parameters: paramter dictionary
    /// - Returns: 생성된 url String
    public class func createUrl(relativePath: String, parameters: [String: Any]? = nil) -> String {
        var url = apiPath() + validate(relativePath: relativePath).apiEncoded
        
        if let param = parameters {
            let query = queryString(with: param)
            url = url.appending(query)
        }
        
        return url
    }
}

extension UrlBuilder {
    
    fileprivate class func apiPath() -> String {
        return "http://13.125.28.166/"
    }
    
    // 주소 앞에 /가 붙어있으면 제거한다.
    fileprivate class func validate(relativePath: String) -> String {
        if relativePath.firstCharacterAsString == "/" {
            return String(relativePath.dropFirst())
        } else {
            return relativePath
        }
    }
    
    /// API에 URL Query 파라미터를 사용할 때, Dictionary를 Query로 파싱하는 메소드
    public class func queryString(with param: [String: Any], startsWithQuestionMark: Bool = true) -> String {
        var query = ""
        
        for key in param.keys {
            guard let value = param[key] else { continue }
            
            if query.count == 0 {
                query = startsWithQuestionMark ? "?" : ""
            } else {
                query = query.appending("&")
            }
            
            if let arrayValue = value as? QueryConvertable {
                query = query.appending(arrayValue.queryString(key: key))
            } else {
                query = query.appending("\(key)=\((value as? String)?.apiParameterEncoded ?? value)")
            }
        }
        
        return query
    }
}

protocol QueryConvertable {
    func queryString(key: String) -> String
}

// Element가 .description을 가지는 Array
extension Array: QueryConvertable where Element: CustomStringConvertible {
    public func queryString(key: String) -> String {
        return map({ return "\(key)=\($0.description.apiParameterEncoded)"}).joined(separator: "&")
    }
}
