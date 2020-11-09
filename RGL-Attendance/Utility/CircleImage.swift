//
//  CircleImage.swift
//  RGL-Attendance
//
//  Created by rgl on 5/10/20.
//  Copyright © 2020 royalgreen. All rights reserved.
//

import SwiftUI

struct CircleImage: View {
    
    @State var frameSize: CGFloat
    @State var lineWidth: CGFloat
    @State var shadowSize: CGFloat
    
    var body: some View {
        VStack {
            Image("avatar-male")
            .resizable()
            .frame(width: frameSize,height: frameSize)
            .clipShape(Circle())
                .overlay(Circle().stroke(Colors.blueAccentTheme, lineWidth: lineWidth))
                .shadow(color: Colors.blueAccentTheme,radius: shadowSize).accentColor(Colors.blueAccentTheme)
            
        }
        
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(frameSize: 120, lineWidth: 1, shadowSize: 8)
    }
}
