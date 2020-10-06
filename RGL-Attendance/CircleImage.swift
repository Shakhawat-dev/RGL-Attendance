//
//  CircleImage.swift
//  RGL-Attendance
//
//  Created by rgl on 5/10/20.
//  Copyright © 2020 royalgreen. All rights reserved.
//

import SwiftUI

struct CircleImage: View {
    var body: some View {
        Image("man-checked")
        .clipShape(Circle())
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage()
    }
}
