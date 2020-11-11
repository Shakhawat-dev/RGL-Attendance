//
//  LoginView.swift
//  RGL-Attendance
//
//  Created by rgl on 6/10/20.
//  Copyright © 2020 royalgreen. All rights reserved.
//

import SwiftUI
import Combine

struct LoginView: View {
    
    @EnvironmentObject var userData: UserData
    @ObservedObject var loginViewModel = LoginViewModel()
    @State private var showLoader = false
    @State private var loginStatusSubscriber: AnyCancellable? = nil
    @State private var loginButtonDisabled = true
    
    // For SecretView
    @State private var showSectretView = false
    
    // For Toast
    @State var showSuccessToast = false
    @State var successMessage: String = ""
    @State var showErrorToast = false
    @State var errorMessage: String = ""
    
    
    var body: some View {
        ZStack {
            VStack( alignment: .center ) {
                Image("RoyalGreenLogo")
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 128,height: 128)
                    .padding(.top, 96)
//                    .onTapGesture {
//                        if !UserLocalStorage.haveUUID() {
//                            let uuid = UUID().uuidString
//
//                            UserLocalStorage.saveUUID(uuid: uuid)
//
//                            self.showSectretView = true
//
//                        } else {
//                            self.showSectretView = true
//                        }
//
//
//                    }.sheet(isPresented: $showSectretView, content: SecretIDView.init)
                
                Text("ROYAL GREEN")
                    .font(.system(.title))
                    .foregroundColor(.yellow)

                HStack {
                    Image(systemName: "person")
                        .frame(width: 18, height: 18)
                        .foregroundColor(Color.gray)
                        .padding(.leading, 8)
                        .padding(.top, 8)
                        .padding(.bottom, 8)
                    
                    TextField("Username", text: $loginViewModel.username)
                    
                }.background(RoundedRectangle(cornerRadius: 32).fill(Color.white))
                .overlay(
                    RoundedRectangle(cornerRadius: 32)
                        .stroke(Color.white, lineWidth: 2)
                        .shadow(radius: 8)
                ).padding(.top, 32)
                .padding(.leading, 32)
                .padding(.trailing, 32)
                
                HStack {
                    Image(systemName: "lock")
                        .frame(width: 18, height: 18)
                        .foregroundColor(Color.gray)
                        .padding(.leading, 8)
                        .padding(.top, 8)
                        .padding(.bottom, 8)
                    
                    SecureField("Password", text: $loginViewModel.password)
                        
                }.background(RoundedRectangle(cornerRadius: 32).fill(Color.white))
                .overlay(
                    RoundedRectangle(cornerRadius: 32)
                        .stroke(Color.white, lineWidth: 2)
                        .shadow(radius: 8)
                ).padding(.top, 8)
                .padding(.leading, 32)
                .padding(.trailing, 32)
                
                Button(action: {
                    self.loginViewModel.doLogIn()
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
                    
                }.onReceive(self.loginViewModel.validatedCredentials) {
                    validateCredential in
                    self.loginButtonDisabled = !validateCredential
                }.onReceive(self.loginViewModel.loginStatusPublisher.receive(on: RunLoop.main)) {
                    isLoggedIn in
                    self.userData.isLoggedIn = isLoggedIn
                    UserLocalStorage.setUserSignedIn(isLogged: isLoggedIn)
                }
                
                Spacer()
                
                Text("Copyright @2020 Royal Green LTD.")
                    .font(.system(.footnote))
                    .foregroundColor(.white)
                
            }.background(Image("Background").resizable().scaledToFill().aspectRatio(contentMode: .fill).edgesIgnoringSafeArea(.all))
            
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
            
        }.colorScheme(.light).onReceive(self.loginViewModel.showLoginLoader.receive(on: RunLoop.main)) { doingSomethingNow in
            self.showLoader = doingSomethingNow
        }.onReceive(self.loginViewModel.successToastPublisher.receive(on: RunLoop.main)) {
            showToast, message in
            self.successMessage = message
            withAnimation() {
                self.showSuccessToast = showToast
            }
        }
        .onReceive(self.loginViewModel.errorToastPublisher.receive(on: RunLoop.main)) {
            showToast, message in
            self.errorMessage = message
            withAnimation() {
                self.showErrorToast = showToast
            }
        }
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
