//
//  APIError.swift
//  TheJakartaPost
//
//  Created by Slamet Riyadi on 20/09/22.
//

import Foundation

enum APIClientError: LocalizedError {
    case custom(String)
    case cannotMapToObject
    case nilValue(String)
    case forbidden              // Status code 403
    case notFound               // Status code 404
    case internalServerError    // Status code 500
    case noInternetConnection
    case badRequest
    
    var errorDescription: String? {
        switch self {
        case .custom(let description):
            return description
        case .noInternetConnection:
            return "Please check your internet connection"
        case .cannotMapToObject:
            return "Cannot map JSON into Decoodable Object"
        case .nilValue(let objectName):
            return "Value of object \(objectName) is null"
        case .forbidden:
            return "You don't have permission access this API"
        case .internalServerError:
            return "You don't have permission access this API"
        case .notFound:
            return "You don't have permission access this API"
        case .badRequest:
            return "Bad request"
        }
        
    }
}
