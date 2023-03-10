//
//  API + Extensions.swift
//  Weath App
//
//  Created by Setthasit Poosawat on 9/3/23.
//

import Foundation

extension API {
    static let baseURL = "https://api.openweathermap.org/data/2.5/"
    
    // MARK: - Weather
    
    static func getCurrentWeather(_ lat: Double, _ lon: Double) -> String {
        return "\(baseURL)weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric"
    }
    
    static func getCurrentWeatherBySearch(_ name: String) -> String {
        return "\(baseURL)weather?q=\(name)&appid=\(apiKey)&units=metric"
    }
    
    // MARK: - Forecast
    
    static func getForecastWeather(_ lat: Double, _ lon: Double) -> String {
        return "\(baseURL)forecast?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric"
    }
    
    static func getForecastWeatherBySearch(_ name: String) -> String {
        return "\(baseURL)forecast?q=\(name)&appid=\(apiKey)&units=metric"
    }
}
