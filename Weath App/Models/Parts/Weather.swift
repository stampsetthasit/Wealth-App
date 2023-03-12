//
//  Weather.swift
//  Weath App
//
//  Created by Setthasit Poosawat on 11/3/23.
//

import Foundation

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
