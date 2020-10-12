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
    
    @State private var showSignoutAlert = false
    @State private var showAttendance = false
    
    private var user = UserLocalStorage.getUserCredentials()
    
    var body: some View {
        ZStack {
            
            VStack{
                UserView(userName: user.loggedUser?.fullName ?? "User", designation: user.loggedUser?.designation ?? "Employee", textColor: .white)
                
                DashboardUserDetailsView()
                
                VStack {
                    HStack {
                        
                        DashboardGridItemView(icon: "Man-checked-icon", text: "Attendance")
                            .onTapGesture {
                            self.showAttendance.toggle()
                        }.sheet(isPresented: $showAttendance, content: AttendanceView.init)
                
                            
                        
                        DashboardGridItemView(icon: "Man-checked-icon", text: "Leave")
                    }
                    HStack {
                        DashboardGridItemView(icon: "Man-checked-icon", text: "Attendance")
                        DashboardGridItemView(icon: "Man-checked-icon", text: "Attendance")
                    }
                    HStack {
                        DashboardGridItemView(icon: "Man-checked-icon", text: "Attendance")
                        DashboardGridItemView(icon: "Man-checked-icon", text: "Signout").onTapGesture {
                            self.showSignoutAlert = true
                            
                        }.alert(isPresented:$showSignoutAlert) {
                            Alert(title: Text("Sign Out"), message: Text("Are you sure to sign out?"), primaryButton: .destructive(Text("Yes")) {
                                UserLocalStorage.clearUserCredentials()
                                self.userData.isLoggedIn = false
                                }, secondaryButton: .cancel(Text("No")))
                        }
                    }
                }.padding()
                
                
                
                Spacer()
            }.background(Image("Background").resizable().scaledToFill().aspectRatio(contentMode: .fill).edgesIgnoringSafeArea(.all))
            
        }
    }
    
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
