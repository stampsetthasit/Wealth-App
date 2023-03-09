//
//  LocationError.swift
//  Weath App
//
//  Created by Setthasit Poosawat on 9/3/23.
//

import Foundation

enum LocationError: Error {
    case failedToGetLocation
    
    var errorDescription: String? {
        switch self {
        case .failedToGetLocation:
            return "Couldn't get current location"
        }
    }
}
