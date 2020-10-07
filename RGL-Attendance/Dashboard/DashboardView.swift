//
//  DashboardView.swift
//  RGL-Attendance
//
//  Created by rgl on 6/10/20.
//  Copyright © 2020 royalgreen. All rights reserved.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
    
        ZStack {
            VStack{
                UserView()
                DashboardUserDetailsView()
                VStack {
                    HStack {
                        DashboardGridItemView(icon: "Man-checked-icon", text: "Attendance")
                        DashboardGridItemView(icon: "Man-checked-icon", text: "Leave")
                    }
                    HStack {
                        DashboardGridItemView(icon: "Man-checked-icon", text: "Attendance")
                        DashboardGridItemView(icon: "Man-checked-icon", text: "Attendance")
                    }
                    HStack {
                        DashboardGridItemView(icon: "Man-checked-icon", text: "Attendance")
                        DashboardGridItemView(icon: "Man-checked-icon", text: "Attendance")
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
