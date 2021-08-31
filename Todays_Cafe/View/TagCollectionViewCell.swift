//
//  CollectionViewCell.swift
//  Todays_Cafe
//
//  Created by SeungMin on 2021/07/22.
//

import UIKit

final class TagCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var tagLabel: UILabel! {
        didSet {
            tagLabel.textColor = .systemTeal
            tagLabel.font = .boldSystemFont(ofSize: 20)
            tagLabel.textAlignment = .left
        }
    }
    
    func update(tagInfo: Tag) {
        tagLabel.text = tagInfo.tagName
    }
}
