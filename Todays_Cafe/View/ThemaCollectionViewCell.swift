//
//  TagCollectionViewCell2.swift
//  Todays_Cafe
//
//  Created by SeungMin on 2021/08/04.
//

import UIKit

final class ThemaCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var themaLabel: UILabel! {
        didSet {
            themaLabel.textColor = .systemTeal
            themaLabel.font = .boldSystemFont(ofSize: 13)
            themaLabel.textAlignment = .center
        }
    }
    
    func updateRecommendation(themaInfo: Tag) {
        themaLabel.text = themaInfo.tagName
    }
    
    func updateRecentSearch(themaInfo: RecentSearchTag) {
        themaLabel.text = themaInfo.tagName
    }
}
