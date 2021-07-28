//
//  TableViewCell.swift
//  Todays_Cafe
//
//  Created by SeungMin on 2021/07/27.
//

import UIKit

final class TableViewCell: UITableViewCell {
    @IBOutlet weak var searchLabel: UILabel!
    
    func update(searchInfo: Search) {
        searchLabel.text = searchInfo.searchText
    }
}
