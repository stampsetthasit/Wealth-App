//
//  WeatherViewModel.swift
//  Weath App
//
//  Created by Setthasit Poosawat on 5/3/23.
//

import SwiftUI

class WeatherViewModel: NSObject, ObservableObject {
    private let locationManager = LocationManager()
    
    @Published var weatherModel: WeatherModel?
    @Published var forecastModel: ForecastModel?
    @Published var errorMessage: String?

    override init() {
        super.init()
        getWeatherData()
    }
    
    // MARK: - Functions for formatting weather data
    
    var cityName: String {
        return self.weatherModel?.name ?? ""
    }
    
    var temp: String {
        return "\(Int(self.weatherModel?.main.temp ?? 0))°C"
    }
    
    var feelsLike: String {
        return "\(Int(self.weatherModel?.main.feelsLike ?? 0))°C"
    }
    
    var descript: String {
        return self.weatherModel?.weather.first?.description.capitalized ?? ""
    }
    
    var windSpeed: String {
        return "\(Int(self.weatherModel?.wind.speed ?? 0)) km/h"
    }
    
    var humidity: String {
        return "\(Int(self.weatherModel?.main.humidity ?? 0))%"
    }
    
    var sunriseTime: String {
        if let sunrise = self.weatherModel?.sys.sunrise {
            return Date.fromUnixTimestamp(sunrise).formatTime()
        }
        return ""
    }
    
    var sunsetTime: String {
        if let sunset = self.weatherModel?.sys.sunset {
            return Date.fromUnixTimestamp(sunset).formatTime()
        }
        return ""
    }
    
    var pressure: String {
        if let pressure = self.weatherModel?.main.pressure {
            let pressureMillibar = Int(Double((pressure)) / 100)
            return "\(pressureMillibar) mb"
        }
        
        return ""
    }
    
    var visibility: String {
        if let visibility = self.weatherModel?.visibility {
            let visibilityInKm = Double(visibility) / 1000
            return "\(visibilityInKm) km"
        }
        return ""
    }
    
    var date: String {
        if let dt = self.weatherModel?.dt {
            return Date.fromUnixTimestamp(dt).formatFullDate()
        }
        return ""
    }
    
    var weatherIcon: Image {
        guard let id = weatherModel?.weather.first?.icon else {
            return Image(systemName: "questionmark.circle")
        }
        return convertWeatherIconFromId(id)
    }
}

extension WeatherViewModel {
    
    // MARK: - Functions for getting the weather data
    
    func getWeatherData() {
        guard let latitude = locationManager.userLocation?.coordinate.latitude.rounded(toPlaces: 2),
              let longitude = locationManager.userLocation?.coordinate.longitude.rounded(toPlaces: 2) else {
            self.errorMessage = "[Location] Location not determined"
            return
        }

        guard let currentWeatherURL = URL(string: API.getCurrentWeather(latitude, longitude)) else {
            self.errorMessage = "[Weather] Invalid URL"
            return
        }

        guard let forecastWeatherURL = URL(string: API.getForecastWeather(latitude, longitude)) else {
            self.errorMessage = "[Forecast] Invalid URL"
            return
        }
        
        NetworkManager.fetch(for: currentWeatherURL, for: forecastWeatherURL) { (result: Result<(WeatherModel, ForecastModel), HTTPError>) in
            switch result {
            case .success(let (response1, response2)):
                DispatchQueue.main.async {
                    self.weatherModel = response1
                    self.forecastModel = response2
                }
            case .failure(let error):
                self.errorMessage = "\(error.errorDescription)\nLat=\(latitude) Lon=\(longitude)"
            }
        }
    }

    
    func getWeatherDataBySearch(_ query: String) {
        guard let currentWeatherURL = URL(string: API.getCurrentWeatherBySearch(query)) else {
            self.errorMessage = "[Weather] Invalid URL"
            return
        }
        
        guard let forecastWeatherURL = URL(string: API.getForecastWeatherBySearch(query)) else {
            self.errorMessage = "[Forecast] Invalid URL"
            return
        }
        
        NetworkManager.fetch(for: currentWeatherURL, for: forecastWeatherURL) { (result: Result<(WeatherModel, ForecastModel), HTTPError>) in
            switch result {
            case .success(let (response1, response2)):
                DispatchQueue.main.async {
                    self.weatherModel = response1
                    self.forecastModel = response2
                }
            case .failure(let error):
                self.errorMessage = error.errorDescription
            }
        }
    }
}
