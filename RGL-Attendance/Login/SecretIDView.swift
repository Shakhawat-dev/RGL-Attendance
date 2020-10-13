//
//  SecretIDView.swift
//  RGL-Attendance
//
//  Created by rgl on 13/10/20.
//  Copyright © 2020 royalgreen. All rights reserved.
//

import SwiftUI

struct SecretIDView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var uuid: String?
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {

                    Text("Hello, Your Secret ID is:")
                        .font(.title)
                        .foregroundColor(Colors.blueTheme)
                    
                    Text("\(uuid ?? "xx-xxxx-xxxxx-xxxxxx")")
                        .font(.subheadline)
                        .foregroundColor(Colors.blueTheme)
                }
            }.navigationBarTitle(Text("User Secret ID"), displayMode: .inline)
                .navigationBarHidden(false)
                .navigationBarItems(trailing: Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Dismiss")
                })
            
        }
        
    }
}

struct SecretIDView_Previews: PreviewProvider {
    static var previews: some View {
        SecretIDView()
    }
}
