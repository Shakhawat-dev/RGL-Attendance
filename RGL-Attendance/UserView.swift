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
            CircleImage()
            VStack(alignment: .leading) {
                Text("Hello, John!")
                    .font(.title)
                Text("Marketing")
                    .font(.system(.subheadline))
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
