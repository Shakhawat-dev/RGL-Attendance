//
//  NetworkApiService.swift
//  RGL-Attendance
//
//  Created by rgl on 7/10/20.
//  Copyright © 2020 royalgreen. All rights reserved.
//

import Foundation
import Combine

class NetworkApiService {
    static let webBaseUrl = "https://api.pacenet.net"
    
    enum APIFailureCondition: Error {
        case InvalidServerResponse
    }
}

func getCommonUrlRequest(url: URL) -> URLRequest {
    //Request type
    let request = URLRequest(url: url)
    //Setting common headers
//    let loggedUser = UserLocalStorage.getUserCredentials().loggedUser
//    request.setValue(loggedUser?.ispToken ?? "", forHTTPHeaderField: "AuthorizedToken")
//    let userId = loggedUser?.userID ?? 0
//    request.setValue(String(userId), forHTTPHeaderField: "userId")
//    request.setValue("3", forHTTPHeaderField: "platformId")
    
    return request
}
