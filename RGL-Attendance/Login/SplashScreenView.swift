//
//  SplashScreenView.swift
//  RGL-Attendance
//
//  Created by rgl on 11/10/20.
//  Copyright © 2020 royalgreen. All rights reserved.
//

import SwiftUI

struct SplashScreenView: View {
    @State var imageAlpha = 0.0
    let splashTime = 1.0
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            HStack(alignment: .center) {
                Spacer()
                Image("RoyalGreenLogo")
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 156, height: 156)
                    .opacity(imageAlpha)
                    .onAppear() {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0 ) {
                            
                            withAnimation(.easeInOut(duration: self.splashTime)) {
                                self.imageAlpha = 1
                            }
                            
                        }
                }
                Spacer()
            }
            Spacer()
        }.background(Image("Background").resizable().scaledToFill())
            .edgesIgnoringSafeArea(.all)
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
