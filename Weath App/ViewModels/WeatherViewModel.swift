//
//  WeatherViewModel.swift
//  Weath App
//
//  Created by Setthasit Poosawat on 5/3/23.
//

/*
// MARK: - How to use?
 
    // Create an instance of the view model
    @StateObject var viewModel = WeatherViewModel()

    var body: some View {
        VStack {
            if let weatherData = viewModel.weatherData {
                Text(viewModel.cityName)
                Text(viewModel.temp)
                Text(viewModel.feelsLike)
                Text(viewModel.descript)
                Text(viewModel.windSpeed)
                Text(viewModel.humidity)
                Text(viewModel.sunriseTime)
                Text(viewModel.sunsetTime)
                Text(viewModel.date)
                Text(viewModel.pressure)
                Text(viewModel.visibility)
                viewModel.weatherIcon
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
            }
        }
        .onAppear {
            // Get the current location and weather data when the view appears
            viewModel.getLocation()
        }
    }

 */

import SwiftUI
import CoreLocation

class WeatherViewModel: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    
    @Published var weatherModel: WeatherModel?
    @Published var errorMessage: String?
    
    override init() {
        super.init()
        self.locationManager.delegate = self
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
        if let dt = self.weatherModel?.timestamp {
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

extension WeatherViewModel: CLLocationManagerDelegate {
    
    // MARK: - Functions for getting the weather data
    
    func getLocation() {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .authorizedWhenInUse, .authorizedAlways:
                self.locationManager.requestLocation()
            case .denied, .restricted:
                self.errorMessage = "Location access denied"
            case .notDetermined:
                self.locationManager.requestWhenInUseAuthorization()
            @unknown default:
                break
            }
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            getCurrentWeatherData()
        case .denied, .restricted:
            self.errorMessage = "Location access denied"
        case .notDetermined:
            break
        @unknown default:
            break
        }
    }
    
    func getCurrentWeatherData() {
        guard let location = locationManager.location else {
            self.errorMessage = "Could not determine location"
            return
        }
        
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        guard let url = URL(string: API.getCurrentWeather(latitude, longitude)) else {
            self.errorMessage = "Invalid URL"
            return
        }
        
        NetworkManager<WeatherModel>.fetch(for: url) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.weatherModel = response
                    self.errorMessage = nil
                }
            case .failure(let error):
                self.errorMessage = error.errorDescription
            }
        }
    }
    
    func getLocationBySearch(_ query: String) {
        guard let url = URL(string: API.getCurrentWeatherBySearch(query)) else {
            self.errorMessage = "Couldn't find the location"
            return
        }
        
        NetworkManager<WeatherModel>.fetch(for: url) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.weatherModel = response
                    self.errorMessage = nil
                }
            case .failure(let error):
                self.errorMessage = error.errorDescription
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard locations.last != nil else { return }
        getCurrentWeatherData()
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.errorMessage = error.localizedDescription
    }
    
}
