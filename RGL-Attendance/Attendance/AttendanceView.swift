//
//  AttendanceView.swift
//  RGL-Attendance
//
//  Created by rgl on 11/10/20.
//  Copyright © 2020 royalgreen. All rights reserved.
//

import SwiftUI
import Combine
import MapKit

struct AttendanceView: View {
    
    @ObservedObject var attendanceViewModel = AttendanceViewModel()
    @ObservedObject private var locationManager = LocationManager()
    
    @Environment(\.presentationMode) var presentationMode
    private var user = UserLocalStorage.getUserCredentials()
    
    @State private var showLoader = false
    @State private var attendanceStatusSubscriber: AnyCancellable? = nil
    
    // For Toast
    @State var showSuccessToast = false
    @State var successMessage: String = ""
    @State var showErrorToast = false
    @State var errorMessage: String = ""
    
//    @Binding var showAttendance: Bool
    
//    let coordinate = locationManager.location?.coordinate ?? CLLocationCoordinate2D()
    
    var body: some View {
         let coordinate = locationManager.location?.coordinate ?? CLLocationCoordinate2D()
        
        return NavigationView {
            ZStack{
                
                VStack {
                    MapView()
                    ZStack {
                        Rectangle()
                            .foregroundColor(.white)
                        
                        VStack {
                            
                            UserView(userName: user.loggedUser?.fullName ?? "User", designation: user.loggedUser?.designation ?? "Employee", textColor: .black)
                            HStack {
                                
                                Text("Enroll Number:  \(user.loggedUser?.enrollNumber ?? "")")
                                    .foregroundColor(Color.black)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }.padding(.leading, 16)
                            
                            
                            
                            Spacer()
                            
                            VStack{
                                
                                    Button(action: {
                                        self.attendanceViewModel.doAttendance()
                                    }) {
                                        Spacer()
                                        Text("GIVE ATTENDANCE")
                                            .foregroundColor(.white)
                                        Spacer()
                                        
                                    }.foregroundColor(.white)
                                        .padding()
                                        .background(Colors.blueTheme)
                                        .cornerRadius(0)
                                        .shadow(radius: 4)
                                        .onReceive(self.attendanceViewModel.attendanceStatusPublisher.receive(on: RunLoop.main)) { attendanceTaken in
                                            
                                            self.presentationMode.wrappedValue.dismiss()
                                            
                                }
                                
                                
                            }.padding()
                            
                        }
                    }.frame(height: 196)
                    
                }
            }.navigationBarTitle(Text("Attendance"), displayMode: .inline)
            .navigationBarHidden(false)
                .navigationBarItems(trailing: Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Dismiss")
                })
            
        }
        
    }
    
    
}

struct AttendanceView_Previews: PreviewProvider {
    static var previews: some View {
        AttendanceView()
        
    }
}
