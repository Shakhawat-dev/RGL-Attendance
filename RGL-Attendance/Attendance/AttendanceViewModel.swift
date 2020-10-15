//
//  AttendanceViewModel.swift
//  RGL-Attendance
//
//  Created by rgl on 12/10/20.
//  Copyright © 2020 royalgreen. All rights reserved.
//

import Foundation
import Combine
import MapKit

class AttendanceViewModel:NSObject, ObservableObject, URLSessionTaskDelegate {
    
    private var attendanceSubscriber: AnyCancellable? = nil
    private let userInfo = UserLocalStorage.getUserCredentials().loggedUser
    
    
    let coordinate = LocationManager().location?.coordinate ?? CLLocationCoordinate2D()
    
    var showAttendanceLoader = PassthroughSubject<Bool, Never>()
    var attendanceStatusPublisher = PassthroughSubject<Bool, Never>()
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
    
    deinit {
        attendanceSubscriber?.cancel()
    }
    
    func urlSession(_ session: URLSession, taskIsWaitingForConnectivity task: URLSessionTask) {
        // waiting for connectivity, update UI, etc.
        self.errorToastPublisher.send((true, "Please turn on your internet connection!"))
    }
    
    func doAttendance(latitude: String, longitude: String) {
        print("Attendance")
        self.attendanceSubscriber = self.executeLoginApiCall(latitude: latitude, longitude: longitude)?
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .finished:
                    break
                    case .failure(let error): self.errorToastPublisher.send((true, error.localizedDescription))
                }
            }, receiveValue: { attendanceResponse in
                if attendanceResponse.resdata.resstate == false {
                    self.errorToastPublisher.send((true, "Attendance could not be taken"))
                } else {
                    self.successToastPublisher.send((true, "Succes!!!, Attendance taken"))
                    self.attendanceStatusPublisher.send(true)
                    print(attendanceResponse)
                    
                    
                
                }
                
            })
    }
    
    func executeLoginApiCall(latitude: String, longitude: String) -> AnyPublisher<AttendanceResponse, Error>? {
        
        let userUUID = UserLocalStorage.getUUID()
        
        // Creating User to JSONArray
        let jsonObject = ["employeeId": userInfo?.employeeId ?? 0,
                          "fullName": userInfo?.fullName ?? "",
                          "designation": userInfo?.designation ?? "",
                          "enrollNumber": userInfo?.enrollNumber ?? "",
                          "ssn": userInfo?.ssn ?? "",
                          "latitude": latitude,
                          "longitude": longitude,
                          "macAddress": userUUID] as [String : Any]
        
        let jsonArray = [jsonObject]
        
        print(jsonArray)
        
        if !JSONSerialization.isValidJSONObject(jsonArray) {
            print("Problem with parameter creation...")
            return nil
        }
        
        let tempJson = try? JSONSerialization.data(withJSONObject: jsonArray, options: [])
        
        guard let jsonData = tempJson else {
            print("Problem with parameter creation...")
            return nil
        }
        
        if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
            print(JSONString)
        }
        
        guard let urlComponents = URLComponents(string: NetworkApiService.webBaseUrl+"/api/employee/setattendancebyusername") else {
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
            self.showAttendanceLoader.send(true)
        }, receiveOutput: { _ in
            self.showAttendanceLoader.send(false)
        }, receiveCompletion: { _ in
            self.showAttendanceLoader.send(false)
        }, receiveCancel: {
            self.showAttendanceLoader.send(false)
        })
            .tryMap { data, response -> Data in guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw NetworkApiService.APIFailureCondition.InvalidServerResponse
                }
                
                return data
        }
        .retry(1)
        .decode(type: AttendanceResponse.self, decoder: JSONDecoder())
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
    
    
}
