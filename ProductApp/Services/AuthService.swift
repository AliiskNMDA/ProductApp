//
//  AuthService.swift
//  ProductApp
//
//  Created by Yusup Aliskantiev on 13.03.2023.
//

import Foundation
import FirebaseAuth


class AuthService {
    
    static let shared = AuthService()
    
    private init(){}
    
    private let auth = Auth.auth()
    
     var currentUser: User? {
        return auth.currentUser
    }
    
    func signOut(){
       try! auth.signOut()
    }
    
    func signUp(email: String,
                password: String,
                complition: @escaping (Result<User, Error>)->()) {
        auth.createUser(withEmail: email, password: password) { result, error in
            if let result = result {
                
                let userInfo = UserInfo(id: result.user.uid, name: "", phone: 0, adress: "")
                DatabaseService.shared.setProfile(user: userInfo) { resultDB in
                    switch resultDB {
                    case .success(_):
                        complition(.success(result.user))
                    case .failure(let error):
                        complition(.failure(error))
                    }
                }
              
            } else if let error = error {
                complition(.failure(error))
            }
        }
    }
    
    func signIn(email: String,
                password: String,
                complition: @escaping (Result<User, Error>)->()) {
        
        auth.signIn(withEmail: email, password: password) { result, error in
            
            if let result {
                complition(.success(result.user))
            } else if let error{
                complition(.failure(error))
            }
            
        }
    }
    
}
