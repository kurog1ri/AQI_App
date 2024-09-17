//
//  SelectedView.swift
//  AQI
//
//  Created by   Kosenko Mykola on 13.09.2024.
//

import Foundation
import SwiftUI
import XCAAQI

struct SelectedView: View {
    let aqi: AQIResponse
    
    var body: some View {
        HStack(spacing: 16) {
            CircleView(aqi: aqi, size: CGSize(width: 80, height: 80))
            VStack(alignment: .leading) {
                Text("Coordinate: \(aqi.coordinate.latitude), \(aqi.coordinate.longitude)")
                Text(aqi.category)
                Text("Dominant Pollutant: \(aqi.dominantPollutant)")
                Text(aqi.displayName)
            }
        }
        .padding(.top)
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
    }
}
