//
//  LoginViewModel.swift
//  RGL-Attendance
//
//  Created by rgl on 6/10/20.
//  Copyright © 2020 royalgreen. All rights reserved.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
}
