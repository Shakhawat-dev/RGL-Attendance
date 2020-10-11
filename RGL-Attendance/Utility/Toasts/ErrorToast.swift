//
//  ErrorToast.swift
//  RGL-Attendance
//
//  Created by rgl on 7/10/20.
//  Copyright © 2020 royalgreen. All rights reserved.
//

import SwiftUI

struct ErrorToast: View {
    var message = ""
    var body: some View {
        VStack {
            Spacer()
            HStack(alignment: .center) {
                Spacer()
                Text(self.message)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                Spacer()
            }
            .padding(.leading, 16)
            .padding(.trailing, 16)
            .padding(.bottom, 10)
            .padding(.top, 10)
            .background(Color.red)
            .cornerRadius(8)
            .shadow(radius: 8)
            .transition(.slide)
        }
        .padding(.leading, 32)
        .padding(.trailing, 32)
        .padding(.bottom, 20)
        .padding(.top, 20)
    }
}

struct ErrorToast_Previews: PreviewProvider {
    static var previews: some View {
        ErrorToast()
    }
}
