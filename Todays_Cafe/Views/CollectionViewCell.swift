//
//  CollectionViewCell.swift
//  Todays_Cafe
//
//  Created by SeungMin on 2021/07/22.
//

import UIKit

final class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var tagLabel: UILabel!
    
    func update(tagInfo: Tag) {
        tagLabel.text = tagInfo.tagName
    }
}
