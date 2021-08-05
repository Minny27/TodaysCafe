//
//  SearchController.swift
//  Todays_Cafe
//
//  Created by SeungMin on 2021/07/31.
//

import UIKit

class TagSearchViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let tagViewModel2 = TagViewModel2()
    
    @IBOutlet weak var tagCollectionView2: UICollectionView! {
        didSet {
            self.tagCollectionView2.layer.borderWidth = 1.5
            self.tagCollectionView2.layer.borderColor = UIColor.lightGray.cgColor
            self.tagCollectionView2.layer.cornerRadius = 10
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
    
    
    @IBOutlet weak var recommendTagBtn: UIButton! {
        didSet {
            self.recommendTagBtn.setTitle("추천 테마", for: .normal)
            self.recommendTagBtn.setTitleColor(.gray, for: .normal)
            self.recommendTagBtn.titleLabel?.font = .boldSystemFont(ofSize: 20)
            self.recommendTagBtn.contentHorizontalAlignment = .right
        }
    }
    
    @IBOutlet weak var recentSearchTagBtn: UIButton! {
        didSet {
            self.recentSearchTagBtn.setTitle("최근 검색 테마", for: .normal)
            self.recentSearchTagBtn.setTitleColor(.gray, for: .normal)
            self.recentSearchTagBtn.titleLabel?.font = .boldSystemFont(ofSize: 20)
            self.recentSearchTagBtn.contentHorizontalAlignment = .left
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tagCollectionView2.delegate = self
        self.tagCollectionView2.dataSource = self
    }
    
    @IBAction func onBackBtnClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onRecommendTagBtnClicked(_ sender: UIButton) {
    }
    
    
    @IBAction func onRecentSearchTagBtnClicked(_ sender: Any) {
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagViewModel2.countTagList
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tagCollectionViewCell2", for: indexPath) as? TagCollectionViewCell2 else { return UICollectionViewCell()
        }
        let cellInfo = tagViewModel2.tagInfo(at: indexPath.item)
        cell.update(tagInfo: cellInfo)
        return cell
    }

}
