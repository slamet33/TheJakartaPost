//
//  NewsTableCell.swift
//  TheJakartaPost
//
//  Created by Slamet Riyadi on 22/09/22.
//

import UIKit

class NewsTableCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func bindView(data: Article) {
        titleLbl.text = data.title
        dateLbl.text = data.publishedDateValue
        imgView.setImageFromNetwork(url: data.gallery?[0].pathThumbnail ?? "")
    }
}
