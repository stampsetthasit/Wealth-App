//
//  WeatherModel.swift
//  Weath App
//
//  Created by Setthasit Poosawat on 7/3/23.
//

import Foundation

struct WeatherModel: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let dt: Int
    let sys: Sys
    let wind: Wind
    
    static var sampleModel = WeatherModel(name: "Bangkok", main: Main(temp: 306.09, tempMin: 305.88, tempMax: 311.43), weather: [Weather(id: 800, description: "clear sky", icon: "01d")], dt: 1678343102, sys: Sys(sunrise: 1678318199, sunset: 1678361254), wind: Wind(speed: 2.96))
}

struct Main: Codable {
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct Sys: Codable {
    let sunrise: Int
    let sunset: Int
}

struct Weather: Codable {
    let id: Int
    let description: String
    let icon: String
}

struct Wind: Codable {
    let speed: Double
}