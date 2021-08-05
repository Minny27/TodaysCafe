//
//  AreaCollecionViewCell.swift
//  Todays_Cafe
//
//  Created by SeungMin on 2021/08/06.
//

import UIKit

final class AreaCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var areaBtn: UIButton! {
        didSet {
            self.areaBtn.setTitleColor(.systemTeal, for: .normal)
            self.areaBtn.titleLabel?.font = .boldSystemFont(ofSize: 22)
            self.areaBtn.contentHorizontalAlignment = .center
        }
    }
    
    func update(areaInfo: Tag) {
        self.areaBtn.setTitle(areaInfo.tagName, for: .normal)
    }
}
