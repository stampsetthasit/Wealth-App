//
//  WeatherViewModel.swift
//  Weath App
//
//  Created by Setthasit Poosawat on 5/3/23.
//

import Foundation

class WeatherViewModel: ObservableObject {
    // MARK: - Properties
    @Published var weatherData: WeatherModel?
    private let firestoreManager = FirestoreManager()
    
    // MARK: - Methods
    func fetchWeatherData(for location: String) {
        let apiService = WeatherAPIService()
        
        apiService.fetchWeatherData(for: location) { result in
            switch result {
            case .success(let data):
                guard let decodedData = try? JSONDecoder().decode(WeatherModel.self, from: data) else {
                    print("Failed to decode weather data.")
                    return
                }
                
                DispatchQueue.main.async {
                    self.weatherData = decodedData
                    self.firestoreManager.saveWeatherData(decodedData)
                }
            case .failure(let error):
                print("Failed to fetch weather data: \(error.localizedDescription)")
            }
        }
    }
}

