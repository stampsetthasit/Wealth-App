//
//  WeatherAPIService.swift
//  Weath App
//
//  Created by Setthasit Poosawat on 5/3/23.
//

import Foundation

class WeatherAPIService {
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    private let apiKey = "a7d28c0e359daa08159c42f9656fe9d6"
    
    func fetchWeatherData(for location: String, completion: @escaping (Result<Data, Error>) -> Void) {
            guard let url = URL(string: "\(baseURL)?q=\(location)&appid=\(apiKey)") else {
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                } else if let data = data {
                    completion(.success(data))
                }
            }
            
            task.resume()
        }
}
