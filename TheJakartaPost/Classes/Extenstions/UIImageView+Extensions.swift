//
//  UIImageView+Extensions.swift
//  TheJakartaPost
//
//  Created by Slamet Riyadi on 20/09/22.
//

import Kingfisher

extension UIImageView {
    
    func setImageFromNetwork(url: String) {
        let checkSpace = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? url
        self.kf.setImage(with: URL(string: checkSpace), placeholder: nil, options: [])
    }
    
}

extension UIImage {

    
}
