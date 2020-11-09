//
//  DashboardUserDetailsView.swift
//  RGL-Attendance
//
//  Created by rgl on 6/10/20.
//  Copyright © 2020 royalgreen. All rights reserved.
//

import SwiftUI

struct DashboardUserDetailsView: View {
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(.white)
                .opacity(0)
                .background(LinearGradient(gradient: Gradient(colors: [Colors.blueTheme, Colors.blueAccentTheme]), startPoint: .leading, endPoint: .trailing))
                .frame(height: 128)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Colors.blueAccentTheme, lineWidth: 1)
                    .shadow(radius: 8))
                

            HStack {
                VStack (alignment: .leading) {
                    Text("Target Hour")
                        .foregroundColor(.white)
                        .font(.system(size: 14))
                    HStack {
                        Text("00")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .font(.system(size: 48))
                        Text("/ 00")
                            .foregroundColor(.white)
                            .font(.system(size: 14))
                            .padding(.top)
                        
                    }
                }
                
                Spacer()
                
                VStack (alignment:.trailing) {
                    Text("Late Count : 0")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .font(.system(size: 14))
                        .padding(4)
                    Text("Total Leave : 0")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .font(.system(size: 14))
                        .padding(4)
                    Text("Available Leave : 0")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .font(.system(size: 14))
                        .padding(4)
                }
                
                
            }.padding()
                
            
            
        }.padding(.leading)
            .padding(.trailing)
        
    }
}

struct DashboardUserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardUserDetailsView()
    }
}
