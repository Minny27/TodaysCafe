//
//  CafeBlogDetailViewController.swift
//  Todays_Cafe
//
//  Created by SeungMin on 2021/08/18.
//

import UIKit
import WebKit

class CafeBlogDetailViewController: UIViewController {
    var cafeBlogURL: String = ""
    
    @IBOutlet var cafeBlogDetailView: WKWebView!
    
    @IBOutlet weak var backBtn: UIButton! {
        didSet {
            self.backBtn.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
            self.backBtn.contentHorizontalAlignment = .fill
            self.backBtn.contentVerticalAlignment = .fill
            self.backBtn.tintColor = .darkGray
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        loadWebView(cafeBlogURL)
    }
    
    func loadWebView(_ blogDetailUrl: String) {
        let url = URL(string: blogDetailUrl)
        let request = URLRequest(url: url!)
        cafeBlogDetailView.load(request)
    }
    
    @IBAction func onBackBtnClicked() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - WKUIDelegate
extension CafeBlogDetailViewController: WKUIDelegate {

}
