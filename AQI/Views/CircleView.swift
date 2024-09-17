//
//  CircleViewAqi.swift
//  AQAppForMyThesis
//
//  Created by   Kosenko Mykola on 06.04.2024.
//

import SwiftUI
import XCAAQI

struct CircleView: View {
    let aqi: AQIResponse
    var isSelected: Bool = false
    var size: CGSize = .init(width: 44, height: 44)
    var body: some View {
        Circle()
            .stroke(Color(red: aqi.color.red, green: aqi.color.green, blue: aqi.color.blue), lineWidth: isSelected ? 4 : 3)
            .frame(width: size.width, height: size.height)
            .overlay {
                Text(aqi.aqiDisplay)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
            }
            .scaleEffect(isSelected ? CGSize(width: 1.5, height: 1.5) : CGSize(width: 1, height: 1))
    }
}

#Preview {
    CircleView(aqi: .init(aqiDisplay: "23", color: .init(red: 0.2, green: 0.5, blue: 0.5)), isSelected: true)
}
