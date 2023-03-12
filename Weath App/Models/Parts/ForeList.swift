//
//  List.swift
//  Weath App
//
//  Created by Setthasit Poosawat on 11/3/23.
//

import Foundation

// MARK: - List
struct ForeList: Codable {
    let dt: Int
    let main: MainClass
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int
    let pop: Double
    let dtTxt: String
    
    enum CodingKeys: String, CodingKey {
        case dt
        case main
        case weather
        case clouds
        case wind
        case visibility
        case pop
        case dtTxt = "dt_txt"
    }
}
