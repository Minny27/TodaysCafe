//
//  ThemaTabbarCollectionViewCell.swift
//  Todays_Cafe
//
//  Created by SeungMin on 2021/09/02.
//

import UIKit

class ThemaTabbarCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var tabbarLabel: UILabel! {
        didSet {
            tabbarLabel.textColor = .gray
            tabbarLabel.font = .boldSystemFont(ofSize: 22)
            tabbarLabel.textAlignment = .center
        }
    }
    
    func update(themaInfo: Tag) {
        tabbarLabel.text = themaInfo.tagName
    }
}
