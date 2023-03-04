//
//  WeatherModel.swift
//  Weath App
//
//  Created by Setthasit Poosawat on 5/3/23.
//

import Foundation

struct WeatherModel: Codable {
    let locationName: String
    let date: Date
    let temperature: Double
    let humidity: Double
    let pressure: Double
    let windSpeed: Double
    let weatherDescription: String
}

