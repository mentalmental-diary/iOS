//
//  LoginBootModule.swift
//  Study_Room
//
//  Created by Joo Young Kim on 2022/01/22.
//

import Foundation
import NaverThirdPartyLogin

class LoginBootModule: BootLoaderProtocol {
    /// 로그인 관련 로드 모듈
    class func loadModule() {
        let instance = NaverThirdPartyLoginConnection.getSharedInstance()
        ///  네이버앱으로 로그인
        instance?.isNaverAppOauthEnable = true
        /// 사파리로 로그인
        instance?.isInAppOauthEnable = true
        
        instance?.serviceUrlScheme = kServiceAppUrlScheme // 앱을 등록할 때 입력한 URL Scheme
        instance?.consumerKey = kConsumerKey // 상수 - client id
        instance?.consumerSecret = kConsumerSecret // pw
        instance?.appName = kServiceAppName // app name
    }
}
