//
//  ErrorModel.swift
//  TheJakartaPost
//
//  Created by Slamet Riyadi on 20/09/22.
//

import Foundation

struct ErrorModel: Codable {
    
    var message: String?
    var detail: String?
    
    init(_ message: String?) {
        self.message = message
    }
    
}
