//
//  UISearchBar+Extensions.swift
//  TheJakartaPost
//
//  Created by Slamet Riyadi on 20/09/22.
//

import UIKit

extension UISearchBar {
    
    func changeBarComponents(bgColor: UIColor = .systemBackground,
                             textColor: UIColor = .white,
                             inset: CGFloat = 22) {
        let insets = NSDirectionalEdgeInsets(top: 0, leading: inset, bottom: 0, trailing: inset)
        self.backgroundColor = .systemBackground
        
        if #available(iOS 13.0, *) {
            self.searchTextField.textColor = textColor
            self.searchTextField.backgroundColor = bgColor
            self.searchTextField.layer.cornerRadius = 20
            self.directionalLayoutMargins = insets
            self.searchTextField.directionalLayoutMargins = insets
            self.searchTextField.layer.masksToBounds = true
        } else {
            for subView in self.subviews {
                for subView1 in subView.subviews {
                    if subView1.isKind(of: UITextField.self) {
                        subView1.backgroundColor = bgColor
                        subView1.layer.cornerRadius = 20
                        subView1.directionalLayoutMargins = insets
                        self.directionalLayoutMargins = insets
                        (subView1 as? UITextField)?.textColor = textColor
                    }
                }
            }
        }
    }
    
}
