//
//  ContentView.swift
//  RGL-Attendance
//
//  Created by rgl on 5/10/20.
//  Copyright © 2020 royalgreen. All rights reserved.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @ObservedObject private var locationManager = LocationManager()
    
    var body: some View {
        //        let coordinate = self.locationManager.location != nil
        //            ? self.locationManager.location!.coordinate : CLLocationCoordinate2D()
        let coordinate = locationManager.location?.coordinate ?? CLLocationCoordinate2D()
        
        print("\(coordinate.latitude) / \(coordinate.longitude)")
        
        return ZStack{
            MapView()
            Text("\(coordinate.latitude) / \(coordinate.longitude)")
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(8)
        }    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
