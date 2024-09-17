//
//  Enum.swift
//  AQI
//
//  Created by   Kosenko Mykola on 13.09.2024.
//

import Foundation
import SwiftUI
import MapKit

enum LocationStatus: Equatable {
    case requestLocation
    case locationAutorized(String)
    case error(String)
    case requestAQIConditions
    case standby
}
