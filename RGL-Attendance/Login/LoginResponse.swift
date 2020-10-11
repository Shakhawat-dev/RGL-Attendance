//
//  LoginResponse.swift
//  RGL-Attendance
//
//  Created by rgl on 7/10/20.
//  Copyright © 2020 royalgreen. All rights reserved.
//

import Foundation

struct LoginResponse: Codable {
    var resdata: LoginResdata
}

struct LoginResdata: Codable {
    var loggedInfo: String?
    var message: String?
    var resstate: Bool?
}

struct LoggedUser: Codable {
    var employeeId: Int?
    var fullName: String?
    var designation: String?
    var enrollNumber: String?
    var ssn: String?
}
