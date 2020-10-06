//
//  Coordinator.swift
//  RGL-Attendance
//
//  Created by rgl on 5/10/20.
//  Copyright © 2020 royalgreen. All rights reserved.
//

import Foundation
import MapKit

final class Coordinator: NSObject, MKMapViewDelegate {
    var control: MapView
    
    init(_ control: MapView) {
        self.control = control
    }
}
