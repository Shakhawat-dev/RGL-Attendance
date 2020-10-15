//
//  AttendanceResponse.swift
//  RGL-Attendance
//
//  Created by rgl on 12/10/20.
//  Copyright © 2020 royalgreen. All rights reserved.
//

import Foundation

struct AttendanceResponse: Codable {
    var resdata: AttendanceResdata
}

struct AttendanceResdata: Codable {
    var message: String?
    var resstate: Bool?
}
