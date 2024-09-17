//
//  ContentView.swift
//  AQAppForMyThesis
//
//  Created by   Kosenko Mykola on 05.04.2024.
//

import SwiftUI
import MapKit
import XCAAQI

struct AQIMainView: View {
    @State var vm = ViewModel()
    
    var body: some View {
        MapView(position: $vm.position, selection: $vm.selection, annotations: vm.annotations)
            .sheet(isPresented: .constant(true)) {
                ScrollView {
                    VStack {
                        if let selection = vm.selection {
                            SelectedView(aqi: selection)
                        } else {
                            if vm.locationStatus != .requestLocation && vm.locationStatus != .requestAQIConditions {
                                LocationFormView(lat: $vm.lat, long: $vm.long, currentLocation: vm.currentLocation) {
                                    await vm.handleCoordinateChange(.init(latitude: vm.lat, longitude: vm.long))
                                }
                            }
                            if vm.locationStatus == .requestAQIConditions {
                                ProgressView("Requesting AQI conditions ... just wait ...")
                            }
                            if vm.locationStatus == .requestLocation {
                                ProgressView("Requesting current locations ... just wait ...")
                            }
                            if case let .locationAutorized(text) = vm.locationStatus {
                                Text(text)
                            }
                            if case let .error(text) = vm.locationStatus {
                                Text(text)
                            }
                        }
                    }
                }
                .padding()
                .safeAreaPadding(.top)
                .presentationDetents([.height(24), .height(176)], selection: $vm.presentationD)
                .presentationBackground(.ultraThinMaterial)
                .presentationBackgroundInteraction(.enabled(upThrough: .height(176)))
                .interactiveDismissDisabled()
            }
            .onChange(of: vm.selection) { oldValue, newValue in
                if oldValue == nil && newValue != nil {
                    vm.presentationD = .height(176)
                }
            }
            .navigationTitle("AQI")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
    }
}

#Preview {
    NavigationStack {
        AQIMainView(vm: .init(radiusArray: []))
            .preferredColorScheme(.dark)
    }
}
