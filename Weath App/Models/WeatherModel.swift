//
//  WeatherModel.swift
//  Weath App
//
//  Created by Setthasit Poosawat on 7/3/23.
//

import Foundation

// MARK: - WeatherModel
struct WeatherModel: Codable {
    let weather: [Weather]
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
}
