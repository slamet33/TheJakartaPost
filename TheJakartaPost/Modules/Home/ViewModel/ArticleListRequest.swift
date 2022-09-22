//
//  ArticleRequest.swift
//  TheJakartaPost
//
//  Created by Slamet Riyadi on 22/09/22.
//

import Foundation

struct ArticleRequest {
    
    static var shared = ArticleRequest()
    
    var channel: String = "seasia"
    var page: Int = 1
    var limit: Int = 10
    
    var path: String = "seasia/2021/05/28/singapore-lifts-import-restrictions-on-food-from-japans-fukushima.html"
    
    var allowNextRequest: Bool = false
    
}

extension ArticleRequest {
    
    func toArticleDetailParam() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary["path"] = path
        return dictionary
    }
    
    func toParameters() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary["limit"] = limit
        dictionary["skip"] = (limit * page) - limit
        return dictionary
    }
    
    func toURLQuery() -> [URLQueryItem] {
        return self.toParameters().map {
            URLQueryItem(name: $0.0, value: "\($0.1)")
        }
    }
    
    func toArticleDetailParamURLQuery() -> [URLQueryItem] {
        return self.toArticleDetailParam().map {
            URLQueryItem(name: $0.0, value: "\($0.1)")
        }
    }
}
