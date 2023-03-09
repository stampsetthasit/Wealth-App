//
//  FirestoreManager.swift
//  Weath App
//
//  Created by Setthasit Poosawat on 5/3/23.
//

import Firebase

//class FirestoreManager {
//
//    static let shared = FirestoreManager()
//    private let db = Firestore.firestore()
//
//    func getWeatherData(for locationName: String, date: Date, completion: @escaping (WeatherModel?) -> Void) {
//
//        let weatherRef = db.collection("weatherData")
//        let query = weatherRef.whereField("locationName", isEqualTo: locationName).whereField("date", isEqualTo: date)
//
//        query.getDocuments { (snapshot, error) in
//            guard let snapshot = snapshot, let document = snapshot.documents.first else {
//                print("Error fetching weather data: \(error?.localizedDescription ?? "Unknown error")")
//                completion(nil)
//                return
//            }
//
//            let data = document.data()
//            let weatherData = WeatherModel(locationName: data["locationName"] as? String ?? "",
//                                          date: data["date"] as? Date ?? Date(),
//                                          temperature: data["temperature"] as? Double ?? 0.0,
//                                          humidity: data["humidity"] as? Double ?? 0.0,
//                                          pressure: data["pressure"] as? Double ?? 0.0,
//                                          windSpeed: data["windSpeed"] as? Double ?? 0.0,
//                                          weatherDescription: data["weatherDescription"] as? String ?? "")
//            completion(weatherData)
//        }
//    }
//
//    func saveWeatherData(_ weatherData: WeatherModel) {
//        let weatherRef = db.collection("weatherData")
//        weatherRef.addDocument(data: [
//            "locationName": weatherData.locationName,
//            "date": weatherData.date,
//            "temperature": weatherData.temperature,
//            "humidity": weatherData.humidity,
//            "pressure": weatherData.pressure,
//            "windSpeed": weatherData.windSpeed,
//            "weatherDescription": weatherData.weatherDescription
//        ]) { error in
//            if let error = error {
//                print("Error saving weather data: \(error.localizedDescription)")
//            } else {
//                print("Weather data saved successfully.")
//            }
//        }
//    }
//
//}
//
//
