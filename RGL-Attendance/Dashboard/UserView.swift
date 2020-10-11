//
//  UserView.swift
//  RGL-Attendance
//
//  Created by rgl on 5/10/20.
//  Copyright © 2020 royalgreen. All rights reserved.
//

import SwiftUI

struct UserView: View {
    
    @State var userName: String
    @State var designation: String
    @State var textColor: Color
    
    var body: some View {
        HStack {
            
            CircleImage(frameSize: 48, lineWidth: 1, shadowSize: 2)
                .padding()
                
            VStack(alignment: .leading) {
                Text("Hello, \(userName)!")
                    .font(.title)
                    .foregroundColor(textColor)
                Text(designation)
                    .font(.system(.subheadline))
                    .foregroundColor(textColor)
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
