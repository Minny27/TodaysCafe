//
//  CityTabbarViewModel.swift
//  Todays_Cafe
//
//  Created by SeungMin on 2021/08/31.
//

import UIKit

final class CityTabbarCollecionViewCell: UICollectionViewCell {
    @IBOutlet weak var cityLabel: UILabel! {
        didSet {
            cityLabel.textColor = .gray
            cityLabel.font = .boldSystemFont(ofSize: 22)
            cityLabel.textAlignment = .center
        }
    }
    
    func update(cityInfo: Tag) {
        cityLabel.text = cityInfo.tagName
    }
}
