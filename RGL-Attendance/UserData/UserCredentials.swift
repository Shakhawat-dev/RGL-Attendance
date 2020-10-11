//
//  UserCredentials.swift
//  RGL-Attendance
//
//  Created by rgl on 8/10/20.
//  Copyright © 2020 royalgreen. All rights reserved.
//

import Foundation
import Combine

//struct UserCredentials {
//    let userName: String
//    let password: String
//    let loggedUser: Logg
//
//    init(userName: String, password: String, loggedUser: String) {
//        self.userName = userName
//        self.password = password
//        self.loggedUser = loggedUser
//    }
//}

struct UserCredentials {
    let userName: String
    let password: String
    let loggedUser: LoggedUser?

    init(userName: String, password: String, loggedUser: LoggedUser?) {
        self.userName = userName
        self.password = password
        self.loggedUser = loggedUser
    }
}
