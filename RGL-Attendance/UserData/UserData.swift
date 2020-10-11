//
//  UserData.swift
//  RGL-Attendance
//
//  Created by rgl on 7/10/20.
//  Copyright © 2020 royalgreen. All rights reserved.
//

import Foundation
import Combine

final class UserData: ObservableObject {
    @Published var selectedTabItem = 0
    @Published var isLoggedIn = false
    @Published var shouldShowSplash = true
    var successToastPublisher = PassthroughSubject<(Bool, String), Never>()
}
