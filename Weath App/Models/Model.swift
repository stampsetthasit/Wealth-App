//
//  Model.swift
//  Weath App
//
//  Created by Setthasit Poosawat on 11/3/23.
//

import Foundation

// MARK: - Model
struct Model: Codable {
    let currentWeather: WeatherModel
    let forecast: ForecastModel
    let airQuality: AirQualityModel
}
