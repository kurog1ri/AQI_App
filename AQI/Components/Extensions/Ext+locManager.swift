//
//  Ext+locManager.swift
//  AQI
//
//  Created by   Kosenko Mykola on 13.09.2024.
//

import Foundation
import SwiftUI
import MapKit


extension ViewModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            manager.requestLocation()
        default:
            self.locationStatus = .locationAutorized("Unauthorized location access")
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        self.locationStatus = .error(error.localizedDescription)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = locations.first?.coordinate else { return }
        if currentLocation == nil {
            lat = coordinate.latitude
            long = coordinate.longitude
            Task { await self.handleCoordinateChange(coordinate)}
        }
        currentLocation = coordinate
    }
}
