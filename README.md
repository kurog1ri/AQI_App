# Air Quality Index (AQI) Measurement App

This SwiftUI app provides real-time air quality information by using the Google AQI API.

## Features
- Displays current air quality index (AQI) based on user’s location.
- Shows detailed air quality information such as main pollutants.
- Regularly updates AQI data in real time.

## Requirements
- Xcode 12+ 
- iOS 14+
- Google AQI API Key

## How to Run the App

To test the app, you need to generate your own Google AQI API key since the one initially used in this project is no longer valid. Follow these steps to get your own API key and integrate it into the app:

1. Visit the [Google Cloud Console](https://console.cloud.google.com/).
2. Clone my project (if you don't already have one).
3. Enable the Air Quality Index (AQI) API.
4. Generate an API key under the APIs & Services section.
5. In the code, find the file where the API key is declared (ViewModel or wherever it is used) and replace the existing API key with your newly generated one.

   Example:
   ```swift
   let aqiClient = AirQualityClient(apiKey: "AIzaSyArKOc04BRBfgaJkW8kT1xfG1gQjXt_kgc")
