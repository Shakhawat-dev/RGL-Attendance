//
//  MainContainerView.swift
//  RGL-Attendance
//
//  Created by rgl on 8/10/20.
//  Copyright © 2020 royalgreen. All rights reserved.
//

import SwiftUI

struct MainContainerView: View {
    
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        VStack {
            if userData.isLoggedIn {
                DashboardView()
            } else {
                SplashLoginContainerView()
            }
        }
    }
}

struct MainContainerView_Previews: PreviewProvider {
    static var previews: some View {
        MainContainerView()
    }
}
