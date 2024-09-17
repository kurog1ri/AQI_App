//
//  LocationFormView.swift
//  AQI
//
//  Created by   Kosenko Mykola on 13.09.2024.
//

import Foundation
import SwiftUI
import MapKit
import XCAAQI

struct LocationFormView: View {
    @Binding var lat: Double
    @Binding var long: Double
    var currentLocation: CLLocationCoordinate2D?
    var handleCoordinateChange: () async -> Void
    
    var body: some View {
        VStack {
            Text("Отримати поточне значення AQI")
                .font(.headline)
                .foregroundColor(.myColor)
                .bold()
                .padding(.bottom, 8)
            
            HStack {
                Text("Latit")
                    .foregroundColor(.myColor)
                    .bold()
                TextField("Enter latitude", value: $lat, format: .number)
                    .foregroundColor(.myColor)
                    .bold()
                Text("Long")
                    .foregroundColor(.myColor)
                    .bold()
                TextField("Enter longitude", value: $long, format: .number)
                    .foregroundColor(.myColor)
                    .bold()
            }
            .keyboardType(.decimalPad)
            .textFieldStyle(.roundedBorder)
            .padding(.bottom, 8)
            
            HStack(spacing: 55) {
                Button("Поточне місце") {
                    lat = currentLocation?.latitude ?? 0
                    long = currentLocation?.longitude ?? 0
                    Task {
                        await handleCoordinateChange()
                    }
                }
                .frame(width: 170, height: 35)
                .background(Color.myColor)
                .foregroundColor(.textColor)
                .cornerRadius(7)
                .shadow(radius: 15)
                .bold()
                
                Button("Оновити AQI") {
                    Task {
                        await handleCoordinateChange()
                    }
                }
                .frame(width: 125, height: 35)
                .background(Color.myColor)
                .foregroundColor(.textColor)
                .cornerRadius(7)
                .shadow(radius: 15)
                .bold()
            }
        }
    }
}
