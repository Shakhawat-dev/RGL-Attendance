//
//  DashboardView.swift
//  RGL-Attendance
//
//  Created by rgl on 6/10/20.
//  Copyright © 2020 royalgreen. All rights reserved.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var userData: UserData
    @ObservedObject private var locationManager = LocationManager()
    
    @State private var showSignoutAlert = false
    @State private var showAttendance = false
    
    private var user = UserLocalStorage.getUserCredentials()
    
    var body: some View {
        ScrollView {
            ZStack {
                
                VStack{
                    UserView(userName: user.loggedUser?.fullName ?? "Userhhf hfhfh siiis hjsjfj jfksjfjffjjllf fjj", designation: user.loggedUser?.designation ?? "Employee", textColor: .white, showButton: true)
                        .padding(.leading)
                        .padding(.trailing, 8)
                    
                    DashboardUserDetailsView()
                    
                    VStack {
                        HStack {
                            
                            if #available(iOS 14.0, *) {
                                DashboardGridItemView(icon: "Man-checked-icon", text: "Attendance")
                                    .onTapGesture {
                                        self.showAttendance.toggle()
                                    }.fullScreenCover(isPresented: $showAttendance, content: AttendanceView.init)
                            } else {
                                // Fallback on earlier versions
                                DashboardGridItemView(icon: "Man-checked-icon", text: "Attendance")
                                    .onTapGesture {
                                        self.showAttendance.toggle()
                                    }.sheet(isPresented: $showAttendance, content: AttendanceView.init)
                            }
                    
                                
                            
                            DashboardGridItemView(icon: "Man-checked-icon", text: "Leave")
                        }
                        HStack {
                            DashboardGridItemView(icon: "Man-checked-icon", text: "Attendance")
                            DashboardGridItemView(icon: "Man-checked-icon", text: "Attendance")
                        }
                        HStack {
                            DashboardGridItemView(icon: "Man-checked-icon", text: "Attendance")
                            DashboardGridItemView(icon: "Man-checked-icon", text: "Attendance")
//                                .onTapGesture {
//                                self.showSignoutAlert = true
//
//                            }.alert(isPresented:$showSignoutAlert) {
//                                Alert(title: Text("Sign Out"), message: Text("Are you sure to sign out?"), primaryButton: .destructive(Text("Yes")) {
//                                    UserLocalStorage.clearUserCredentials()
//                                    self.userData.isLoggedIn = false
//                                    }, secondaryButton: .cancel(Text("No")))
//                            }
                        }
                    }.padding()
                    
                    
                    
                    Spacer()
                }
                
            }
        }
        .background(Image("Background").resizable().scaledToFill().aspectRatio(contentMode: .fill).edgesIgnoringSafeArea(.all))
        
    }
    
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
