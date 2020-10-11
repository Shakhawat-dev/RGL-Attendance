//
//  SpinLoaderView.swift
//  RGL-Attendance
//
//  Created by rgl on 7/10/20.
//  Copyright © 2020 royalgreen. All rights reserved.
//

import SwiftUI

struct SpinLoaderView: View {
    @State var spinCircle = false
    
    var body: some View {
        ZStack {
            Rectangle().frame(width:160, height: 135).background(Color.black).cornerRadius(8).opacity(0.6).shadow(radius: 8)
            VStack {
                Circle()
                    .trim(from: 0.3, to: 1)
                    .stroke(Color.green, lineWidth:3)
                    .frame(width:40, height: 40)
                    .padding(.all, 8)
                    .rotationEffect(.degrees(spinCircle ? 0 : -360), anchor: .center)
                    .animation(Animation.linear(duration: 0.6).repeatForever(autoreverses: false))
                    .onAppear {
                        self.spinCircle = true
                }
                Text("Please wait...").foregroundColor(.white)
            }
        }
    }
}

struct SpinLoaderView_Previews: PreviewProvider {
    static var previews: some View {
        SpinLoaderView()
    }
}
