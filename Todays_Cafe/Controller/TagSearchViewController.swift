//
//  SearchController.swift
//  Todays_Cafe
//
//  Created by SeungMin on 2021/07/31.
//

import UIKit

class TagSearchViewController: UIViewController {
    let themaTabbarViewModel = ThemaTabbarViewModel()
    let recommendationThemaViewModel = RecommendationThemaViewModel()
    var recentSearchThemaViewModel = RecentSearchThemaViewModel()
    var checkThemaHashTable: [String: Int] = ["recommendation": 1, "recentSearch": 0]
    
    @IBOutlet weak var themaTabbarCollectionView: UICollectionView!
    
    @IBOutlet weak var themaCollectionView: UICollectionView! {
        didSet {
            self.themaCollectionView.layer.borderWidth = 1.5
            self.themaCollectionView.layer.borderColor = UIColor.lightGray.cgColor
            self.themaCollectionView.layer.cornerRadius = 10
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
        
        themaTabbarCollectionView.dataSource = self
        themaTabbarCollectionView.delegate = self
        themaCollectionView.dataSource = self
        themaCollectionView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let areaSearchViewController = segue.destination as? AreaSearchViewController else { return }
        if let tagInfo = sender as? Tag {
            areaSearchViewController.tagName = tagInfo.tagName
        }
    }
    
    func saveNewTag(_ tagId: String, _ tagName: String) {
        CoreDataManager.shared.saveRecentTag(tagId, tagName)
    }
    
    func getTagInfoList() {
        recentSearchThemaViewModel.themaList = CoreDataManager.shared.getRecentTag()
    }
    
    @IBAction func onBackBtnClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource
extension TagSearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == themaTabbarCollectionView {
            return themaTabbarViewModel.countThemaList
        }
        else {
            if checkThemaHashTable["recommendation"] == 1 {
                return recommendationThemaViewModel.countThemaList
            }
            else {
                return recentSearchThemaViewModel.countThemaList
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == themaTabbarCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "themaTabbarCollectionViewCell", for: indexPath) as? ThemaTabbarCollectionViewCell else { return UICollectionViewCell()
            }
            let themaInfo = themaTabbarViewModel.themaInfo(at: indexPath.item)
            cell.update(themaInfo: themaInfo)
            return cell
        }
        else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "themaCollectionViewCell", for: indexPath) as? ThemaCollectionViewCell else { return UICollectionViewCell()
            }
            if checkThemaHashTable["recommendation"] == 1 {
                let themaInfo = recommendationThemaViewModel.themaInfo(at: indexPath.item)
                cell.updateRecommendation(themaInfo: themaInfo)
                return cell
            }
            else {
                let themaInfo = recentSearchThemaViewModel.themaInfo(at: indexPath.item)
                cell.updateRecentSearch(themaInfo: themaInfo)
                return cell
            }
        }
        
    }
}

// MARK: - UICollectionViewDelegate
extension TagSearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == themaTabbarCollectionView {
            var checkThemaHashTableCache = checkThemaHashTable
            let tabbarInfo = themaTabbarViewModel.themaInfo(at: indexPath.item)
            
            if tabbarInfo.tagId == "recommendation" {
                checkThemaHashTableCache["recommendation"] = 1
                checkThemaHashTableCache["recentSearch"] = 0
            }
            else {
                checkThemaHashTableCache["recommendation"] = 0
                checkThemaHashTableCache["recentSearch"] = 1
                getTagInfoList()
            }
            if checkThemaHashTableCache != checkThemaHashTable {
                checkThemaHashTable = checkThemaHashTableCache
                themaCollectionView.reloadData()
            }
        }
        
        else {
            let themaInfo = recommendationThemaViewModel.themaInfo(at: indexPath.item)
            performSegue(withIdentifier: "tagSearchVCToAreaSearchVC", sender: themaInfo)
            saveNewTag(themaInfo.tagId, themaInfo.tagName)
        }
    }
}
