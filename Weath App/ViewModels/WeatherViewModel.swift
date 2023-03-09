//
//  WeatherViewModel.swift
//  Weath App
//
//  Created by Setthasit Poosawat on 5/3/23.
//

import Foundation
import CoreLocation

final class WeatherViewModel: ObservableObject {
    @Published var weatherModel = WeatherModel.sampleModel
    @Published var city = "Bangkok" {
        didSet {
            getLocation()
        }
    }
    @Published var isLoading = false
    @Published var error: HTTPError?
    
    init() {
        getLocation()
    }
    
    private func getLocation() {
        isLoading = true
        error = nil
        CLGeocoder().geocodeAddressString(city) { placemarks, error in
            if let placemark = placemarks,
               let place = placemarks?.first {
                self.getWeather(place.location?.coordinate)
            } else {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.error = .invalidCityName
                }
            }
        }
    }
    
    private func getWeather(_ coord: CLLocationCoordinate2D?) {
        var urlString = ""
        if let coord = coord {
            urlString = API.getCurrentWeather(coord.latitude, coord.longitude)
        } else {
            urlString = API.getCurrentWeather(100.5167, 13.75)
        }
        getWeatherInternal(city: city, for: urlString)
    }
    
    private func getWeatherInternal(city: String, for urlString: String) {
        guard let url = URL(string: urlString) else { return }
        isLoading = true
        error = nil
        NetworkManager<WeatherModel>.fetch(for: url) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.weatherModel = response
                    self.isLoading = false
                case .failure(let error):
                    self.error = error
                    self.isLoading = false
                }
            }
        }
    }
    
    func refreshWeather() {
        getLocation()
    }
    
}

