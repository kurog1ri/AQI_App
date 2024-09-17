//
//  MapView.swift
//  AQI
//
//  Created by   Kosenko Mykola on 13.09.2024.
//

import SwiftUI
import MapKit
import XCAAQI

struct MapView: View {
    @Binding var position: MapCameraPosition
    @Binding var selection: AQIResponse?
    let annotations: [AQIResponse]
    
    var body: some View {
        Map(position: $position, selection: $selection) {
            ForEach(annotations) { aqi in
                Annotation(aqi.aqiDisplay, coordinate: aqi.coordinate) {
                    CircleView(aqi: aqi, isSelected: aqi == selection)
                }
                .tag(aqi)
                .annotationTitles(.hidden)
            }
        }
        .mapStyle(.hybrid(elevation: .flat, pointsOfInterest: .all, showsTraffic: false))
    }
}


