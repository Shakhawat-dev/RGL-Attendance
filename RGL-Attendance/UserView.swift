//
//  UserView.swift
//  RGL-Attendance
//
//  Created by rgl on 5/10/20.
//  Copyright © 2020 royalgreen. All rights reserved.
//

import SwiftUI

struct UserView: View {
    var body: some View {
        HStack {
            
            CircleImage(frameSize: 48, lineWidth: 1, shadowSize: 2)
                .padding()
                
            VStack(alignment: .leading) {
                Text("Hello, John!")
                    .font(.title)
                    .foregroundColor(.white)
                Text("Marketing")
                    .font(.system(.subheadline))
                    .foregroundColor(.white)
            }
            Spacer()
            
        }
        
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
