//
//  ViewModel.swift
//  AQAppForMyThesis
//
//  Created by   Kosenko Mykola on 05.04.2024.
//

import Foundation
import MapKit
import Observation
import SwiftUI
import XCAAQI

@Observable
class ViewModel: NSObject {
    let locationManager = CLLocationManager()
    let aqiClient = AirQualityClient(apiKey: "AIzaSyArKOc04BRBfgaJkW8kT1xfG1gQjXt_kgc")
    let coordinatesFinder = CoordinatesFinder()
    
    var currentLocation: CLLocationCoordinate2D?
    var locationStatus = LocationStatus.requestLocation
    var position: MapCameraPosition = .automatic
    var annotations: [AQIResponse] = []
    var selection: AQIResponse?
    var presentationD = PresentationDetent.height(176)
    var lat: Double = 0
    var long: Double = 0
    
    var radiusArray: [(Double, Int)]
    
    init(radiusArray: [(Double, Int)] = [(4000, 6), (8000, 12)]) {
        self.radiusArray = radiusArray
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    @MainActor
    func handleCoordinateChange(_ coordinate: CLLocationCoordinate2D) async {
        do {
            self.locationStatus = .requestAQIConditions
            self.position = .region(.init(center: coordinate, latitudinalMeters: 0, longitudinalMeters: 16000))
            let coordinates = getCoordinates(coordinate)
            self.annotations = try await aqiClient.getCurrentConditions(coordinates: coordinates.map {($0.latitude, $0.longitude)})
            self.locationStatus = .standby
        } catch {
            self.locationStatus = .error(error.localizedDescription)
        }
    }
    func getCoordinates(_ coordinate: CLLocationCoordinate2D) -> [CLLocationCoordinate2D] {
        var results: [CLLocationCoordinate2D] = [coordinate]
        radiusArray.forEach {
            results += coordinatesFinder.findCoordinates(coordinate, r: $0.0, n: $0.1)
        }
        return results
    }
}



