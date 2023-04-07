//
//  UserManager.swift
//  Study_Room
//
//  Created by Joo Young Kim on 2022/02/12.
//

import Foundation
import Alamofire
import SwiftyJSON

class UserManager: ObservableObject {
    public var userModel: UserModel?
    
    @Published var loginCheck: Bool?

    public func requestLoginUser(completion: @escaping ((Result<UserModel, Error>) -> Void)) {
        // 여기서 로그인 api호출을 진행할 거고
    }
}
