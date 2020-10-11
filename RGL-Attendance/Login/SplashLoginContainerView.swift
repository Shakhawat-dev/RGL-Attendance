//
//  SplashLoginContainerView.swift
//  RGL-Attendance
//
//  Created by rgl on 11/10/20.
//  Copyright © 2020 royalgreen. All rights reserved.
//

import SwiftUI

struct SplashLoginContainerView: View {
    
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        ZStack {
            LoginView()
            SplashScreenView()
                .opacity(self.userData.shouldShowSplash ? 1 : 0)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        if UserLocalStorage.isLoggedIn() {
                            self.userData.isLoggedIn = true
                        }
                        self.userData.shouldShowSplash = false
                    }
            }
        }
    }
}

struct SplashLoginContainerView_Previews: PreviewProvider {
    static var previews: some View {
        SplashLoginContainerView()
    }
}
