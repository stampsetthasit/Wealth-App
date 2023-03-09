//
//  HTTPError.swift
//  Weath App
//
//  Created by Setthasit Poosawat on 9/3/23.
//

import Foundation

enum HTTPError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case decodingError(err: String)
    case error(error: String)
    
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid Response"
        case .invalidData:
            return "Invalid Data"
        case .decodingError(let err):
            return "Decoding Error: \(err)"
        case .error(let error):
            return "Error: \(error)"
        }
    }
}
