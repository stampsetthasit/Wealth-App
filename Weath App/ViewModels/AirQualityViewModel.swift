//
//  AirQualityViewModel.swift
//  Weath App
//
//  Created by Setthasit Poosawat on 21/3/23.
//

import SwiftUI
import CoreLocation

class AirQualityViewModel: NSObject, ObservableObject {

    private let locationManager = CLLocationManager()

    @Published var airQualityModel: AirQualityModel?
    @Published var errorMessage: String?

    override init() {
        super.init()
        self.locationManager.delegate = self
        getAirData()
    }

    // MARK: - Functions for formatting air quality data

    func formatCO() -> String {
        guard let components = airQualityModel?.list.first?.components,
              let coValue = components["co"] else {
            return "N/A"
        }
        return String(format: "%.2f ppm", coValue)
    }

    func formatNO() -> String {
        guard let components = airQualityModel?.list.first?.components,
              let noValue = components["no"] else {
            return "N/A"
        }
        return String(format: "%.2f ppb", noValue)
    }

    func formatNO2() -> String {
        guard let components = airQualityModel?.list.first?.components,
              let no2Value = components["no2"] else {
            return "N/A"
        }
        return String(format: "%.2f ppb", no2Value)
    }

    func formatPM25() -> String {
        guard let components = airQualityModel?.list.first?.components,
              let pm25Value = components["pm2_5"] else {
            return "N/A"
        }
        return String(format: "%.2f µg/m³", pm25Value)
    }

    func formatAirQualityIndex() -> String {
        return "\(airQualityModel?.list.first?.main.aqi ?? 0)"
    }
    
}


extension AirQualityViewModel: CLLocationManagerDelegate {
    private func getAirData() {
        guard let location = locationManager.location else {
            self.errorMessage = "[Location] Could not determine location"
            return
        }
        
        guard let airQualityURL = URL(string: API.getAirQuality(location.coordinate.latitude, location.coordinate.longitude)) else {
            self.errorMessage = "[Weather] Invalid URL"
            return
        }
        
        NetworkManager.fetch(for: airQualityURL) { (result: Result<AirQualityModel, HTTPError>) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.airQualityModel = response
                }
            case .failure(let error):
                self.errorMessage = error.errorDescription
            }
        }
    }
}
