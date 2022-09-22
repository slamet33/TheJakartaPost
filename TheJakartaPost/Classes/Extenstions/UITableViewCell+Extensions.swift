//
//  UITableViewCell+Extensions.swift
//  TheJakartaPost
//
//  Created by Slamet Riyadi on 20/09/22.
//

import UIKit

extension UITableView {
    func register(_ cells: [UITableViewCell.Type]) {
        for cell in cells {
            register(cell.self, forCellReuseIdentifier: cell.defaultIdentifier)
        }
    }
    
    func registerXIB(_ cells: [UITableViewCell.Type]) {
        for cell in cells {
            register(cell.defaultNib, forCellReuseIdentifier: cell.defaultIdentifier)
        }
    }
    
    func dequeueReusableCell<T: UITableViewCell>() -> T? {
        return dequeueReusableCell(withIdentifier: T.defaultIdentifier) as? T
    }
    
    func reloadSectionWithoutAnimation(section: IndexSet) {
        let cachedOffset = contentOffset
        reloadSections(section, with: .none)
        layoutIfNeeded()
        setContentOffset(cachedOffset, animated: false)
    }
    
    func reloadWithoutAnimation() {
        let cachedOffset = contentOffset
        reloadData()
        layoutIfNeeded()
        setContentOffset(cachedOffset, animated: false)
    }
    
    func updatesWithoutAnimation() {
        let cachedOffset = contentOffset
        beginUpdates()
        endUpdates()
        setContentOffset(cachedOffset, animated: false)
    }
    
    func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
        return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
    }
    
    func scrollToTop(section: Int = 0, animated: Bool) {
        let indexPath = IndexPath(row: 0, section: section)
        if self.hasRowAtIndexPath(indexPath: indexPath) {
            self.scrollToRow(at: indexPath, at: .top, animated: animated)
        }
    }
}

extension UITableViewCell {
    static var defaultIdentifier: String {
        return String(describing: self)
    }
    
    static var defaultNib: UINib {
        return UINib(nibName: defaultIdentifier, bundle: Bundle(for: self))
    }
}
