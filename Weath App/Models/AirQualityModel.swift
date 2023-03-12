//
//  AirQualityModel.swift
//  Weath App
//
//  Created by Setthasit Poosawat on 11/3/23.
//

import Foundation

// MARK: - AirQualityModel
struct AirQualityModel: Codable {
    let list: [AQIReading]
}

// MARK: - AQIReading
struct AQIReading: Codable {
    let main: Main
    let components: [String: Double]
    let dt: Int
}
