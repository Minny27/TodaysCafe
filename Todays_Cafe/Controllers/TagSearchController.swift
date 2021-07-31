//
//  SearchController.swift
//  Todays_Cafe
//
//  Created by SeungMin on 2021/07/31.
//

import UIKit

class TagSearchController: UIViewController {
    @IBOutlet weak var backBtn: UIButton! {
        didSet {
            self.backBtn.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
            self.backBtn.contentHorizontalAlignment = .fill
            self.backBtn.contentVerticalAlignment = .fill
            self.backBtn.tintColor = .darkGray
        }
    }
    
    @IBAction func onClickBackBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
