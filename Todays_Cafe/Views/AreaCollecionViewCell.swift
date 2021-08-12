//
//  AreaCollecionViewCell.swift
//  Todays_Cafe
//
//  Created by SeungMin on 2021/08/06.
//

import UIKit

final class AreaCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var areaLabel: UILabel! {
        didSet {
            areaLabel.textColor = .systemTeal
            areaLabel.font = .boldSystemFont(ofSize: 22)
            areaLabel.textAlignment = .center
        }
    }
    
    func update(areaInfo: Tag) {
        areaLabel.text = areaInfo.tagName
    }
}
