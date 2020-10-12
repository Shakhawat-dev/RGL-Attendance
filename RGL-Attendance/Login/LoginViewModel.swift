//
//  LoginViewModel.swift
//  RGL-Attendance
//
//  Created by rgl on 6/10/20.
//  Copyright © 2020 royalgreen. All rights reserved.
//

import Foundation
import Combine

class LoginViewModel: NSObject, ObservableObject, URLSessionTaskDelegate {
    @Published var username: String = ""
    @Published var password: String = ""
    
    private var loginSubscriber: AnyCancellable? = nil
    
    var showLoginLoader = PassthroughSubject<Bool, Never>()
    var loginStatusPublisher = PassthroughSubject<Bool, Never>()
    var errorToastPublisher = PassthroughSubject<(Bool, String), Never>()
    var successToastPublisher = PassthroughSubject<(Bool, String), Never>()
    
    let config = URLSessionConfiguration.default
    
    var session: URLSession {
        get {
            config.timeoutIntervalForResource = 5
            config.waitsForConnectivity = true
            return URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue());
        }
    }
    
    var validatedCredentials: AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest($username, $password)
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .receive(on: RunLoop.main) // <<—— run on main thread
            .map { username, password in
                guard !username.isEmpty, !password.isEmpty else { return false }
                return true
        }
        .eraseToAnyPublisher()
    }
    
    deinit {
        loginSubscriber?.cancel()
    }
    
    func urlSession(_ session: URLSession, taskIsWaitingForConnectivity task: URLSessionTask) {
        // waiting for connectivity, update UI, etc.
        self.errorToastPublisher.send((true, "Please turn on your internet connection!"))
    }
    
    func doLogIn() {
        self.loginSubscriber = self.executeLoginApiCall()?
        .sink(receiveCompletion: { completion in
            switch completion {
                case .finished:
                break
                case .failure(let error): self.errorToastPublisher.send((true, error.localizedDescription))
            }
        }, receiveValue: { loginResponse in
            if loginResponse.resdata.resstate == false {
                self.errorToastPublisher.send((true, loginResponse.resdata.message ?? "Something wrong, Please try again"))
            } else {
                self.loginStatusPublisher.send(true)
                print(loginResponse)
                
                let loggedUser: LoggedUser
                
                // For String to JSON
                guard let userString = loginResponse.resdata.loggedInfo else {
                    print("Problem with parameter creation...")
                    return
                }
                
                let data = userString.data(using: .utf8)!
                
                do {
                    if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>]
                    {
//                        loggedUser = jsonArray[0]
                        print(jsonArray) // use the json here
                        
                        let user = LoggedUser(employeeId: jsonArray[0]["employeeId"] as? Int, fullName: jsonArray[0]["fullName"] as? String, designation: jsonArray[0]["designation"] as? String, enrollNumber: jsonArray[0]["enrollNumber"] as? String, ssn: jsonArray[0]["ssn"] as? String)
                        
                        loggedUser = user
                        
                        print(loggedUser)
                        
//                        Saving User info into defaults
                        UserLocalStorage.saveUserCredentials(userCredentials: UserCredentials(userName: self.username, password: self
                            .password, loggedUser: loggedUser))
                        
                    } else {
                        print("bad json")
                    }
                } catch let error as NSError {
                    print(error)
                }
                
//                UserLocalStorage.saveUserCredentials(userCredentials: UserCredentials(userName: self.username, password: self
//                    .password, loggedUser: loggedUser))
//
                // MARK: ///// START FROM HERE /////////
            }
        })
    }
    
    func executeLoginApiCall() -> AnyPublisher<LoginResponse, Error>? {
        // Creating User to JSONArray
        let jsonObject = ["userName": self.username, "userPass": self.password]
        let jsonArray = [jsonObject]
        
        if !JSONSerialization.isValidJSONObject(jsonArray) {
            print("Problem with parameter creation...")
            return nil
        }
        
        let tempJson = try? JSONSerialization.data(withJSONObject: jsonArray, options: [])
        
        guard let jsonData = tempJson else {
            print("Problem with parameter creation...")
            return nil
        }
        
        guard let urlComponents = URLComponents(string: NetworkApiService.webBaseUrl+"/api/employee/attendbyusername") else {
            print("Problem with URLComponent creation...")
            return nil
        }
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        // Request type
        var request = getCommonUrlRequest(url: url)
        request.httpMethod = "POST"
        
        // Setting headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Setting body for POST request
        request.httpBody = jsonData
        
        return session.dataTaskPublisher(for: request).handleEvents(receiveSubscription: { _ in
            self.showLoginLoader.send(true)
        }, receiveOutput: { _ in
            self.showLoginLoader.send(false)
        }, receiveCompletion: { _ in
            self.showLoginLoader.send(false)
        }, receiveCancel: {
            self.showLoginLoader.send(false)
        })
            .tryMap { data, response -> Data in guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw NetworkApiService.APIFailureCondition.InvalidServerResponse
                }
                
                return data
        }
        .retry(1)
        .decode(type: LoginResponse.self, decoder: JSONDecoder())
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}
