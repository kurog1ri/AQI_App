//
//  CoordinateFinder.swift
//  AQAppForMyThesis
//
//  Created by   Kosenko Mykola on 06.04.2024.
//

import Foundation
import CoreLocation

struct CoordinatesFinder {
    
    let R = 6371000.0
    let pi = 3.141592653589793

    
    func deg2rad(_ deg: Double) -> Double {
        return deg * pi / 180
    }
    
    func rad2deg(_ rad: Double) -> Double {
        return rad * 180 / pi
    }

    func findCoordinates(_ coordinate: CLLocationCoordinate2D, r: Double, n: Int) -> [CLLocationCoordinate2D] {
        let phi1 = deg2rad(coordinate.latitude)
        let lambda1 = deg2rad(coordinate.longitude)
        let d = r / R
        
        var coordinates: [CLLocationCoordinate2D] = []
      
        for i in 0..<n {
            
            let theta = deg2rad(Double(i) * 360 / Double(n))
            
            let phi2 = asin(sin(phi1) *  cos(d) + cos(phi1) * sin(d) * cos(theta))
            let lambda2 = lambda1 + atan2(sin(theta) * sin(d) * cos(phi1), cos(d) - sin(phi1) * sin(phi2))
           
            let lat2 = rad2deg(phi2)
            let lon2 = rad2deg(lambda2)
            
            coordinates.append(.init(latitude: lat2, longitude: lon2))
        }
        
        return coordinates
    }
}

      
