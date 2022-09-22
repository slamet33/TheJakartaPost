//
//  NewsEndPoint.swift
//  TheJakartaPost
//
//  Created by Slamet Riyadi on 22/09/22.
//

import Foundation

enum ArticleEndPoint: APIConfiguration {
    
    case articleList(request: ArticleRequest)
    case articleDetail(request: ArticleRequest)
    
    // MARK: - Path
    internal var path: String {
        switch self {
        case .articleList(let request):
            return "articles/\(request.channel)"
        case .articleDetail:
            return "article/url"
        }
    }
    
    var baseURLType: BaseURLType {
        switch self {
        case .articleList, .articleDetail:
            return .baseUrlUser
        }
    }
    
    // MARK: - BaseURL with Path Components
    internal var baseURL: URL {
        let url: URL = URL(string: Environment.baseApiURL)!
        let baseURL = url.appendingPathComponent(path)
        return baseURL
    }
    
    // MARK: - Query Items / Parameters
    internal var queryItems: [URLQueryItem]? {
        let query = components.queryItems
        return query
    }
    
    // MARK: - URL Components / Parameters
    internal var components: URLComponents {
        
        guard var components =  URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
            fatalError("Couldn't create URLComponents")
        }
        
        switch self {
        case .articleList(let params):
            components.queryItems = params.toURLQuery()
        case .articleDetail(let params):
            components.queryItems = params.toArticleDetailParamURLQuery()
        }
        return components
    }
    
    // MARK: - URL Request
    var urlRequest: URLRequest {
        let request = URLRequest(url: components.url!)
        
        switch self {
        case .articleList, .articleDetail:
            return request
        }
    }
    
}
