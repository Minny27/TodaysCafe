//
//  CafeBlogDetailViewController.swift
//  Todays_Cafe
//
//  Created by SeungMin on 2021/08/18.
//

import UIKit
import WebKit

class CafeBlogDetailViewController: UIViewController {
    var cafeBlogUrlString: String = ""
    
    @IBOutlet var cafeBlogDetailView: WKWebView!
    
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            self.backButton.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
            self.backButton.contentHorizontalAlignment = .fill
            self.backButton.contentVerticalAlignment = .fill
            self.backButton.tintColor = .darkGray
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        loadWebView(cafeBlogUrlString)
    }
    
    func loadWebView(_ blogDetailUrl: String) {
        guard let url = URL(string: blogDetailUrl)
        else {
            print(NetworkError.invalidURL)
            return
        }
        
        let request = URLRequest(url: url)
        cafeBlogDetailView.load(request)
    }
    
    @IBAction func onBackBtnClicked() {
        dismiss(animated: false, completion: nil)
    }
}
