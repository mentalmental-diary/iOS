//
//  LoginNetworkModel.swift
//  Study_Room
//
//  Created by JooYoung Kim on 2022/05/03.
//

import Foundation
import SwiftyJSON

class LoginNetworkModel {
    func requestLoginUser(completion: @escaping ((Result<UserModel, Error>) -> Void)) {
        let api = "login"
        
        APIRequest.requestJSON(api: api, method: .post, completion: { result in
            if let json = result.success, let user = UserModel(json: json) {
                self.setCurrentUserInfo(json: json)
                completion(.success(user))
            } else {
                completion(.failure(result.error ?? CommonError.failedToFetch))
            }
        })
    }
    
    func setCurrentUserInfo(json: JSON) {
        guard let email = json["email"].string,
              let nickname = json["nickname"].string,
              let accessToken = json["accessToken"].string,
              let refreshToken = json["refreshToken"].string else { return }
        
        UserDefaults.standard.set(email, forKey: "email")
        UserDefaults.standard.set(nickname, forKey: "nickname")
        UserDefaults.standard.set(accessToken, forKey: "accessToken")
        UserDefaults.standard.set(refreshToken, forKey: "refreshToken")
        UserDefaults.standard.set(true, forKey: "isLogin")
    }
}
