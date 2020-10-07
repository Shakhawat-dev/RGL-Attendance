//
//  LoginView.swift
//  RGL-Attendance
//
//  Created by rgl on 6/10/20.
//  Copyright © 2020 royalgreen. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var loginViewModel = LoginViewModel()
    
    var body: some View {
        
        VStack( alignment: .center ) {
            Image("RoyalGreenLogo")
                .resizable()
                .scaledToFit()
                .aspectRatio(contentMode: .fit)
                .frame(width: 128,height: 128)
                .padding(.top, 96)
            
            Text("ROYAL GREEN")
                .font(.system(.title))
                .foregroundColor(.yellow)
            
            
            TextField("Username", text: $loginViewModel.username)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .cornerRadius(32)
                .padding(.top, 32)
                .padding(.leading, 32)
                .padding(.trailing, 32)
            
            TextField("Username", text: $loginViewModel.username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .cornerRadius(32)
                .padding(.top, 8)
                .padding(.leading, 32)
                .padding(.trailing, 32)
            
            Button(action: {
                print("Button Tapped")
            }) {
                HStack{
                    Spacer()
                    Text("Login")
                        .foregroundColor(Color.white)
                        .padding(.top, 8)
                        .padding(.bottom, 8)
                        
                    Spacer()
                }.overlay(
                    RoundedRectangle(cornerRadius: 32)
                        .stroke(Color.white, lineWidth: 2)
                    .shadow(radius: 8)
                ).padding(.top, 8)
                    .padding(.leading, 32)
                    .padding(.trailing, 32)
            
            }
            
            Spacer()
            
            Text("Copyright @2020 Royal Green LTD.")
                .font(.system(.footnote))
                .foregroundColor(.white)
            
            }.background(Image("Background").resizable().scaledToFill().aspectRatio(contentMode: .fill).edgesIgnoringSafeArea(.all))
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
