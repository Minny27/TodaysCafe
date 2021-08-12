//
//  CafeBlogTableViewController.swift
//  Todays_Cafe
//
//  Created by SeungMin on 2021/08/09.
//

import UIKit
import SwiftSoup

class CafeBlogTableViewController: UIViewController {
    var tagName: String?
    var areaName: String?
    
    @IBOutlet weak var backBtn: UIButton! {
        didSet {
            self.backBtn.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
            self.backBtn.contentHorizontalAlignment = .fill
            self.backBtn.contentVerticalAlignment = .fill
            self.backBtn.tintColor = .darkGray
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("\(areaName!) \(tagName!) 카페")
    }
    
    @IBAction func onBackBtnClicked() {
        dismiss(animated: true, completion: nil)
    }
}
