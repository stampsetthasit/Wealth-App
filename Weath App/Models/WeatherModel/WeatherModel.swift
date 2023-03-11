//
//  WeatherModel.swift
//  Weath App
//
//  Created by Setthasit Poosawat on 7/3/23.
//

import Foundation

struct WeatherModel: Codable {
    let name: String
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let sys: Sys
    let forecast: [Forecast]?
    let timestamp: Int
    let visibility: Int

    enum CodingKeys: String, CodingKey {
        case name
        case weather
        case main
        case wind
        case sys
        case timestamp = "dt"
        case forecast = "list"
        case visibility
    }
}

struct Main: Codable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
    }
}

struct Sys: Codable {
    let sunrise: Int
    let sunset: Int
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Wind: Codable {
    let speed: Double
    let direction: Int?

    enum CodingKeys: String, CodingKey {
        case speed
        case direction = "deg"
    }
}

struct Forecast: Codable {
    let timestamp: Date?
    let weather: [Weather]
    let main: Main
    let wind: Wind

    enum CodingKeys: String, CodingKey {
        case timestamp = "dt"
        case weather
        case main
        case wind
    }
}
