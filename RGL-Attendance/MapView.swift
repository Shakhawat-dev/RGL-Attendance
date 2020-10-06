//
//  MapView.swift
//  RGL-Attendance
//
//  Created by rgl on 5/10/20.
//  Copyright © 2020 royalgreen. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @ObservedObject private var locationManager = LocationManager()
    
    func makeUIView(context: Context) -> MKMapView {
        let coordinate = locationManager.location?.coordinate ?? CLLocationCoordinate2D()
        
        let map = MKMapView()
        
        let userCoordinate = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let eyeCoordinate = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let mapCamera = MKMapCamera(lookingAtCenter: userCoordinate, fromEyeCoordinate: eyeCoordinate, eyeAltitude: 400.0)
        let annotation = MKPointAnnotation()
        
        let noLocation = CLLocationCoordinate2D()
        let viewRegion = MKCoordinateRegion(center: noLocation, latitudinalMeters: 200, longitudinalMeters: 200)
        //        map.setRegion(viewRegion, animated: false)
        
        map.showsUserLocation = true
        //        map.camera = mapCamera
        map.delegate = context.coordinator
        
        return map
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        
    }
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//    }
//}
