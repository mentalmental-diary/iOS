//
//  Alamofire+Extension.swift
//  Study_Room
//
//  Created by JooYoung Kim on 2022/01/27.
//

import Foundation
import Alamofire

extension DataResponse {
    
    func getRawJson() -> String? {
        guard let data = self.data else { return nil }
        
        return String(data: data, encoding: String.Encoding.utf8)
    }
}

extension Session {
    class func createInstance(retrier: RequestInterceptor?) -> Session {
        // https://github.com/Alamofire/Alamofire/issues/2722#issuecomment-511484938
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 10 // seconds
        
        return Session(configuration: configuration, interceptor: retrier)
    }
}
