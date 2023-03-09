//
//  API + Extensions.swift
//  Weath App
//
//  Created by Setthasit Poosawat on 9/3/23.
//

import Foundation

extension API {
    static let baseURL = "https://api.openweathermap.org/data/2.5/"
    
    static func getCurrentWeather(_ lat: Double, _ lon: Double) -> String {
        return "\(baseURL)weather?lat=\(lat)&lon=\(lon)&exclude=minutely&appid=\(apiKey)&units=metric"
    }
    
    static func getSearchWeather(_ name: String) -> String {
        return "\(baseURL)weather?q=\(name)&appid=\(apiKey)&units=metric"
    }
}
