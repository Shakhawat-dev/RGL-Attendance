//
//  UserLocalStorage.swift
//  RGL-Attendance
//
//  Created by rgl on 7/10/20.
//  Copyright © 2020 royalgreen. All rights reserved.
//

import Foundation
import Combine

struct UserLocalStorage {
    private static let userDefault = UserDefaults.standard
    
    // Managing SignedIn
    static func setUserSignedIn(isLogged: Bool) {
        userDefault.set(isLogged, forKey: "isLoggedIn")
    }
    
    static func isLoggedIn() -> Bool {
        return userDefault.value(forKey: "isLoggedIn") as? Bool ?? false
    }
    
    // Managing UUID
    static func saveUUID(uuid: String) {
        userDefault.setValue(uuid, forKey: "userUUID")
    }
    
    static func getUUID() -> String {
        return userDefault.value(forKey: "userUUID") as? String ?? ""
    }
    
    static func haveUUID() -> Bool {
        if userDefault.value(forKey: "userUUID") != nil {
            return true
        } else {
            return false
        }
    }
    
    static func saveUserCredentials(userCredentials: UserCredentials) {
        
        let encoder = JSONEncoder()
        if let encodedLoggedUser = try?
            encoder.encode(userCredentials.loggedUser) {
            userDefault.set(userCredentials.userName, forKey: "userNameCreden")
            userDefault.set(userCredentials.password, forKey: "passwordCreden")
            userDefault.set(encodedLoggedUser, forKey: "loggedUserCreden")
            
            print(String(data: encodedLoggedUser, encoding: .utf8)!)
        }
        
    }
    
    static func getUserCredentials() -> UserCredentials {
        var loggedUser: LoggedUser? = nil
        
        if let decodeLoggedUser = userDefault.object(forKey: "loggedUserCreden") as? Data {
            let decoder = JSONDecoder()
            if let loadedLoggedUser = try? decoder.decode(LoggedUser.self, from: decodeLoggedUser) {
                loggedUser = loadedLoggedUser
            }
        }
        return UserCredentials(userName: userDefault.value(forKey: "userNameCreden") as? String ?? "", password: userDefault.value(forKey: "passwordCreden") as? String ?? "", loggedUser: loggedUser)
    }
    
    static func clearUserCredentials(){
        userDefault.removeObject(forKey: "userNameCreden")
        userDefault.removeObject(forKey: "passwordCreden")
        userDefault.removeObject(forKey: "loggedUserCreden")
        userDefault.set(false, forKey: "isLoggedIn")
        
    }
    
    
}
