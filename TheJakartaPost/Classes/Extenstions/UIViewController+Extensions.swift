//
//  UIViewController+Extensions.swift
//  TheJakartaPost
//
//  Created by Slamet Riyadi on 20/09/22.
//

import UIKit

extension UIViewController {
    
    func showMessage(_ message: String, title: String, completion: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Retry", style: .default) { _ in
            completion?()
        }
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
}
