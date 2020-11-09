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
    @State private var showAttendanceAlert = false
    @State private var attendanceStatusSubscriber: AnyCancellable? = nil
    
    // For Toast
    @State var showSuccessToast = false
    @State var successMessage: String = ""
    @State var showErrorToast = false
    @State var errorMessage: String = ""
    
    //    @Binding var showAttendance: Bool
    
    //    let coordinate = locationManager.location?.coordinate ?? CLLocationCoordinate2D()
    
    var body: some View {
        
        NavigationView {
            ZStack{
                
                VStack {
                    MapView()
                    ZStack {
                        Rectangle()
                            .foregroundColor(.white)
                        
                        VStack {
                            
                            UserView(userName: user.loggedUser?.fullName ?? "User dfjbfsbkfk fkbfjk  skjfbjksfbjk sfkjbfskj", designation: user.loggedUser?.designation ?? "Employee", textColor: .black)
                                .padding(.leading)
                            HStack {
                                
                                Text("Enroll Number:  \(user.loggedUser?.enrollNumber ?? "")")
                                    .foregroundColor(Color.black)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }.padding(.leading, 16)
                            
                            
                            
                            Spacer()
                            
                            VStack{
                                
                                Button(action: {
                                    let coordinate = locationManager.location?.coordinate ?? CLLocationCoordinate2D()
                                    if (String(coordinate.latitude) == "0.0" && String(coordinate.longitude) == "0.0" ) {
                                        errorMessage = "No Geo location"
                                        showErrorToast = true
                                    } else {
                                        self.attendanceViewModel.doAttendance(latitude: String(coordinate.latitude), longitude: String(coordinate.longitude))
                                    }
                                    
                                }) {
                                    Spacer()
                                    Text("SUBMIT ATTENDANCE")
                                        .foregroundColor(.white)
                                    Spacer()
                                    
                                }.foregroundColor(.white)
                                .padding()
                                .background(Colors.blueTheme)
                                .cornerRadius(0)
                                .shadow(radius: 4)
                                .onReceive(self.attendanceViewModel.attendanceStatusPublisher.receive(on: RunLoop.main)) { attendanceTaken in
                                    
                                    self.showAttendanceAlert = true
                                    
                                    
                                }.alert(isPresented: $showAttendanceAlert) {
                                    Alert(title: Text("Attendance Taken!"), message: Text("You successfully submitted your attendance"), dismissButton: .default(Text("Okey")){
                                        self.presentationMode.wrappedValue.dismiss()
                                    })
                                }
                                
                                // Action Sheet
                                //                                    .actionSheet(isPresented: $showAttendanceAlert) { () -> ActionSheet in
                                //                                            ActionSheet(title: Text("Attendance Taken!").font(.headline), message: Text("You successfully submitted your attendance").font(.callout), buttons: [
                                //                                                .default(Text("Okey"), action: {
                                //                                                    self.presentationMode.wrappedValue.dismiss()
                                //                                                })
                                //                                            ])
                                //                                        }
                                
                                
                                
                            }.padding()
                            
                        }
                    }.frame(height: 196)
                    
                    
                    
                }
                
                if self.showSuccessToast {
                    SuccessToast(message: self.successMessage).onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation() {
                                self.showSuccessToast = false
                                self.successMessage = ""
                            }
                        }
                    }
                }
                
                if showErrorToast {
                    ErrorToast(message: self.errorMessage).onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation() {
                                self.showErrorToast = false
                                self.errorMessage = ""
                            }
                        }
                    }
                }
                
                if showLoader {
                    SpinLoaderView()
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onReceive(self.attendanceViewModel.showAttendanceLoader.receive(on: RunLoop.main)) { doingSomethingNow in
                self.showLoader = doingSomethingNow
            }.onReceive(self.attendanceViewModel.successToastPublisher.receive(on: RunLoop.main)) {
                showToast, message in
                self.successMessage = message
                withAnimation() {
                    self.showSuccessToast = showToast
                }
            }
            .onReceive(self.attendanceViewModel.errorToastPublisher.receive(on: RunLoop.main)) {
                showToast, message in
                self.errorMessage = message
                withAnimation() {
                    self.showErrorToast = showToast
                }
            }
            .navigationBarTitle(Text("Attendance"), displayMode: .inline)
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
