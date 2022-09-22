//
//  ApiConfiguration.swift
//  TheJakartaPost
//
//  Created by Slamet Riyadi on 20/09/22.
//

import Foundation

protocol APIConfiguration {
    var baseURL: URL { get }
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
    var components: URLComponents { get }
    var baseURLType: BaseURLType { get }
    var urlRequest: URLRequest { get }
}

enum HTTPHeaderField: String {
    case authorization = "Authorization"
    case contentType = "Content-Type"
    case clientId = "clientId"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case localization = "X-Localization"
    case xApiKey = "X-Api-Key"
    
}

enum BaseURLType: String {
    case baseApiUrlPartner = "BASE_API_URL_PARTNER"
    case baseApiUrlSupport = "BASE_API_URL_SUPPORT"
    case baseApiUrlUnit = "BASE_API_URL_UNIT"
    case baseUrlUser = "BASE_API_URL"
    case mocking = "MOCK_API"
}

enum ContentType: String {
    case json = "application/json"
    case form = "application/x-www-form-urlencoded"
}

enum UploadState {
    case uploading(progress: Int)
    case success(url: String)
}

enum DownloadState {
    case downloading(progress: Int)
    case success(url: String)
}

enum HttpMethod: String {
    case post   = "POST"
    case put    = "PUT"
    case get    = "GET"
    case delete = "DELETE"
}

extension URLRequest {
    
    mutating func embedHeaders() {
        addValue("c49ac003-8cad-404f-b967-83c809eb9c33", forHTTPHeaderField: HTTPHeaderField.xApiKey.rawValue)
        addValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
    }
}
