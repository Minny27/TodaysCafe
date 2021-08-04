//
//  TagCollectionViewCell2.swift
//  Todays_Cafe
//
//  Created by SeungMin on 2021/08/04.
//

import UIKit

final class TagCollectionViewCell2: UICollectionViewCell {
    
    @IBOutlet weak var tagBtn: UIButton! {
        didSet {
            self.tagBtn.setTitleColor(.systemTeal, for: .normal)
            self.tagBtn.titleLabel?.font = .boldSystemFont(ofSize: 18)
            self.tagBtn.contentHorizontalAlignment = .left
        }
    }
    
    func update(tagInfo: Tag) {
        self.tagBtn.setTitle(tagInfo.tagName, for: .normal)
    }
}
