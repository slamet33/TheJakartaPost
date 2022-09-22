//
//  UICollectionView+Extensions.swift
//  TheJakartaPost
//
//  Created by Slamet Riyadi on 20/09/22.
//

import UIKit

extension UICollectionView {
    func register(_ cells: [UICollectionViewCell.Type]) {
        for cell in cells {
            register(cell.self, forCellWithReuseIdentifier: cell.defaultIdentifier)
        }
    }
    
    func reloadWithoutAnimation() {
        let cachedOffset = contentOffset
        reloadData()
        layoutIfNeeded()
        setContentOffset(cachedOffset, animated: false)
    }
}

extension UICollectionViewCell {
    
    static var defaultIdentifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: defaultIdentifier, bundle: nil)
    }
}
