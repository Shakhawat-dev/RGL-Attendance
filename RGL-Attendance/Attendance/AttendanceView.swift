//
//  AttendanceView.swift
//  RGL-Attendance
//
//  Created by rgl on 11/10/20.
//  Copyright © 2020 royalgreen. All rights reserved.
//

import SwiftUI
import Combine

struct AttendanceView: View {
    private var user = UserLocalStorage.getUserCredentials()
    
    var body: some View {
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
                                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                                    Spacer()
                                    Text("GIVE ATTENDANCE")
                                        .foregroundColor(.white)
                                    Spacer()
                                    
                                }.foregroundColor(.white)
                                    .padding()
                                    .background(Colors.blueTheme)
                                    .cornerRadius(0)
                                    .shadow(radius: 4)
                            }.padding()
                            
                        }
                    }.frame(height: 196)
                    
                }
            }
        }
        
    
}

struct AttendanceView_Previews: PreviewProvider {
    static var previews: some View {
        AttendanceView()
        
    }
}
