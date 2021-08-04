//
//  CollectionViewCell.swift
//  Todays_Cafe
//
//  Created by SeungMin on 2021/07/22.
//

import UIKit

final class TagCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tagBtn: UIButton! {
        didSet {
            self.tagBtn.setTitleColor(.systemTeal, for: .normal)
            self.tagBtn.titleLabel?.font = .boldSystemFont(ofSize: 20)
            self.tagBtn.contentHorizontalAlignment = .left
        }
    }
    
    func update(tagInfo: Tag) {
        self.tagBtn.setTitle(tagInfo.tagName, for: .normal)
    }
}
