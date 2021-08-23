//
//  TagCollectionViewCell2.swift
//  Todays_Cafe
//
//  Created by SeungMin on 2021/08/04.
//

import UIKit

final class TagCollectionViewCell2: UICollectionViewCell {
    @IBOutlet weak var tagLabel: UILabel! {
        didSet {
            tagLabel.textColor = .systemTeal
            tagLabel.font = .boldSystemFont(ofSize: 15)
            tagLabel.textAlignment = .center
        }
    }
    
    func update(tagInfo: Tag) {
        tagLabel.text = tagInfo.tagName
    }
}
