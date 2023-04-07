//
//  LoginManager.swift
//  Study_Room
//
//  Created by JooYoung Kim on 2022/04/30.
//

import Foundation
import SwiftyJSON

class LoginViewModel: ObservableObject {
    @Published var userEmail: String = ""
    @Published var userPassword: String = ""
    @Published var isToastShow: Bool = false
    
    private let networkModel = LoginNetworkModel()
    
    var errorMessage: Error?
    
    func fetchLoginUser(completion: @escaping ((Result<UserModel, Error>) -> Void)) {
        networkModel.requestLoginUser(completion: { [weak self] result in
            switch result {
            case .success(let user):
                completion(.success((user)))
            case .failure(let error):
                debugLog("로그인 실패 : \(error.localizedDescription)")
                self?.errorMessage = error
                completion(.failure(error))
            }
        })
    }
}
