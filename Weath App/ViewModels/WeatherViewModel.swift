//
//  WeatherViewModel.swift
//  Weath App
//
//  Created by Setthasit Poosawat on 5/3/23.
//

import SwiftUI
import CoreLocation

final class WeatherViewModel: ObservableObject {
    @Published var weatherModel = WeatherModel.sampleModel
    @Published var city = "Bangkok" {
        didSet {
            getLocation()
        }
    }
    @Published var isLoading = false
    @Published var error: LocationError?
    
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
                    self.error = .failedToGetLocation
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
        NetworkManager<WeatherModel>.fetch(for: url) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.weatherModel = response
                    self.isLoading = false
                case .failure(let error):
                    print(error)
                    self.isLoading = false
                }
            }
        }
    }
    
    func refreshWeather() {
        getLocation()
    }
    
//    var date: String {
//        return Time.defaultDateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.current.date)) )
//    }

    var weatherIcon: String {
        return weatherModel.weather[0].icon
    }

    var temperature: String {
        return getTempFor(weatherModel.main.temp)
    }
    
    var conditions: Int {
        return weatherModel.weather[0].id
    }

    var windSpeed: String {
        return String(format: "%0.1f", weatherModel.wind.speed)
    }

    var humidity: String {
        return String(format: "%d%%", weatherModel.main.humidity)
    }

//    var rainChances: String {
//        return String(format: "%0.1f%%", weather.current.dewPoint)
//    }

//    func getTimeFor(_ temp: Int) -> String {
//        return Time.timeFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(temp)))
//    }
//
//    func getDayFor(_ temp: Int) -> String {
//        return Time.dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(temp)))
//    }
//    
//    func getDayNumber(_ temp: Int) -> String {
//        return Time.dayNumberFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(temp)))
//    }

    func getTempFor(_ temp: Double) -> String {
        return String(format: "%.1f", temp)
    }
    
    func getWeatherIcon(id icon: String) -> Image {
            switch icon {
                case "01d":
                    return Image("sun")
                case "01n":
                    return Image("moon")
                case "02d":
                    return Image("cloudSun")
                case "02n":
                    return Image("cloudMoon")
                case "03d":
                    return Image("cloud")
                case "03n":
                    return Image("cloudMoon")
                case "04d":
                    return Image("cloudMax")
                case "04n":
                    return Image("cloudMoon")
                case "09d":
                    return Image("rainy")
                case "09n":
                    return Image("rainy")
                case "10d":
                    return Image("rainySun")
                case "10n":
                    return Image("rainyMoon")
                case "11d":
                    return Image("thunderstormSun")
                case "11n":
                    return Image("thunderstormMoon")
                case "13d":
                    return Image("snowy")
                case "13n":
                    return Image("snowy-2")
                case "50d":
                    return Image("tornado")
                case "50n":
                    return Image("tornado")
                default:
                    return Image("sun")
            }
        }
}

