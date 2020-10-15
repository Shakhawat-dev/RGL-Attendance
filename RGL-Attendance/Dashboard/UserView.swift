//
//  UserView.swift
//  RGL-Attendance
//
//  Created by rgl on 5/10/20.
//  Copyright © 2020 royalgreen. All rights reserved.
//

import SwiftUI

struct UserView: View {
    
    @EnvironmentObject var userData: UserData
    
    @State var userName: String
    @State var designation: String
    @State var textColor: Color
    @State var showButton = false
    
    @State private var showSignoutAlert = false
    
    var body: some View {
        HStack {
            
            CircleImage(frameSize: 48, lineWidth: 1, shadowSize: 2)
                .padding()
                
            HStack {
            VStack(alignment: .leading) {
                
                    Text("Hello, \(userName)!")
                        .font(.title)
                        .foregroundColor(textColor)
                    
                Text(designation)
                    .font(.system(.subheadline))
                    .foregroundColor(textColor)
                    
                }
                
                Spacer()
                
                if showButton {
                    Button(action: {
                        self.showSignoutAlert = true
                    }) {
                        Image(systemName: "escape")
                        .resizable()
                        .frame(width: 32, height: 32, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .foregroundColor(Colors.blueAccentTheme)
                            .padding()
                    }
    .alert(isPresented:$showSignoutAlert) {
                        Alert(title: Text("Sign Out"), message: Text("Are you sure to sign out?"), primaryButton: .destructive(Text("Yes")) {
                            UserLocalStorage.clearUserCredentials()
                            self.userData.isLoggedIn = false
                            }, secondaryButton: .cancel(Text("No")))
                    }
                }
                
                
            }
            Spacer()
            
        }
        
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(userName: "John", designation: "Marketing", textColor: .black)
    }
}
