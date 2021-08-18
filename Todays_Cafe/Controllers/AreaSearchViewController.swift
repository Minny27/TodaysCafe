//
//  areaSearchController.swift
//  Todays_Cafe
//
//  Created by SeungMin on 2021/07/31.
//

import UIKit

class AreaSearchViewController: UIViewController {
    let areaViewModel = AreaViewModel()
    let areaCollectionViewCell = AreaCollectionViewCell()
    var tagName: String?
    
    @IBOutlet weak var areaCollectionView: UICollectionView! {
        didSet {
            self.areaCollectionView.layer.borderWidth = 1.5
            self.areaCollectionView.layer.borderColor = UIColor.lightGray.cgColor
            self.areaCollectionView.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var seoulBtn: UIButton! {
        didSet {
            self.seoulBtn.setTitle("서울", for: .normal)
            self.seoulBtn.setTitleColor(.gray, for: .normal)
            self.seoulBtn.titleLabel?.font = .boldSystemFont(ofSize: 20)
            self.seoulBtn.contentHorizontalAlignment = .center
        }
    }
    
    @IBOutlet weak var gyeonggiBtn: UIButton! {
        didSet {
            self.gyeonggiBtn.setTitle("경기", for: .normal)
            self.gyeonggiBtn.setTitleColor(.gray, for: .normal)
            self.gyeonggiBtn.titleLabel?.font = .boldSystemFont(ofSize: 20)
            self.gyeonggiBtn.contentHorizontalAlignment = .center
        }
    }
    
    @IBOutlet weak var inchonBtn: UIButton! {
        didSet {
            self.inchonBtn.setTitle("인천", for: .normal)
            self.inchonBtn.setTitleColor(.gray, for: .normal)
            self.inchonBtn.titleLabel?.font = .boldSystemFont(ofSize: 20)
            self.inchonBtn.contentHorizontalAlignment = .center
        }
    }
    
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
        
        self.areaCollectionView.dataSource = self
        self.areaCollectionView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cafeBlogTableViewController = segue.destination as? CafeBlogTableViewController else { return }
        if let areaInfo = sender as? Tag {
            cafeBlogTableViewController.areaName = areaInfo.tagName
        }
        if let tagName = self.tagName {
            cafeBlogTableViewController.tagName = tagName
        }
    }
    
    @IBAction func onClickBackBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource
extension AreaSearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return areaViewModel.countAreaList
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "areaCollectionViewCell", for: indexPath) as? AreaCollectionViewCell else {
            return UICollectionViewCell()
        }
        let areaInfo = areaViewModel.areaInfo(at: indexPath.item)
        cell.update(areaInfo: areaInfo)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension AreaSearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let areaInfo = areaViewModel.areaInfo(at: indexPath.item)
        performSegue(withIdentifier: "areaSearchVCToCafeBlogTableVC", sender: areaInfo)
    }
}
