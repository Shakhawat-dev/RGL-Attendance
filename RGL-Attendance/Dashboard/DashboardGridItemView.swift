//
//  DashboardGridItemView.swift
//  RGL-Attendance
//
//  Created by rgl on 6/10/20.
//  Copyright © 2020 royalgreen. All rights reserved.
//

import SwiftUI

struct DashboardGridItemView: View {
    
    @State var icon: String
    @State var text: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .cornerRadius(8)
                .foregroundColor(Colors.blueTheme)
                .frame(height: 128)
                .opacity(0.6)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Colors.blueAccentTheme, lineWidth: 1)
                        .shadow(radius: 8))
            VStack {
                Image(icon)
                .resizable()
                    .frame(width: 64, height: 64)
                
                Text(text)
                    .foregroundColor(.white)
            }
        }.padding(8)
    }
}

struct DashboardGridItemView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardGridItemView(icon: "Man-checked-icon", text: "Attendance")
    }
}
