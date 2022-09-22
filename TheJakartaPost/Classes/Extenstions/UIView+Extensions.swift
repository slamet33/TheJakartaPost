//
//  UIView+Extensions.swift
//  TheJakartaPost
//
//  Created by Slamet Riyadi on 20/09/22.
//

import UIKit

public extension UIView {
  func addSubviews(_ views: UIView...) {
    for view in views {
      addSubview(view)
    }
  }
}
