//
//  ForecastModel.swift
//  Weath App
//
//  Created by Setthasit Poosawat on 11/3/23.
//

import Foundation

// MARK: - ForecastModel
struct ForecastModel: Codable {
    let list: [ForeList]
    let city: City
}
