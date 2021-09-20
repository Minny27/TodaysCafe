//
//  ViewController.swift
//  Todays_Cafe
//
//  Created by SeungMin on 2021/07/16.
//

import UIKit
import FSPagerView

class HomeViewController: UIViewController {
    let bannerViewModel = BannerViewModel()
    let tagViewModel = TagViewModel()
    
    @IBOutlet weak var tagCollectionView: UICollectionView!
    
    @IBOutlet weak var tagSearchBtn: UIButton! {
        didSet {
            self.tagSearchBtn.setTitle("원하는 테마를 검색해보세요!", for: .normal)
            self.tagSearchBtn.setTitleColor(.gray, for: .normal)
            self.tagSearchBtn.titleLabel?.font = .boldSystemFont(ofSize: 17)
            self.tagSearchBtn.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
            self.tagSearchBtn.contentHorizontalAlignment = .left
            self.tagSearchBtn.titleEdgeInsets.left = 30
            self.tagSearchBtn.imageEdgeInsets.left = 20
            self.tagSearchBtn.tintColor = .gray
            self.tagSearchBtn.layer.cornerRadius = 10
            self.tagSearchBtn.layer.borderWidth = 1.5
            self.tagSearchBtn.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    @IBOutlet weak var myPagerView: FSPagerView! {
        didSet {
            self.myPagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.myPagerView.itemSize = FSPagerViewAutomaticSize
            self.myPagerView.automaticSlidingInterval = 4.0
        }
    }
    
    @IBOutlet weak var myPageControl: FSPageControl! {
        didSet {
            self.myPageControl.numberOfPages = self.bannerViewModel.countBannerList
            self.myPageControl.contentHorizontalAlignment = .center
            self.myPageControl.itemSpacing = 15
        }
    }
    
    // MARK: - ViewDidLoad 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myPagerView.dataSource = self
        self.myPagerView.delegate = self
        self.tagCollectionView.dataSource = self
        self.tagCollectionView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let areaSearchViewController = segue.destination as? AreaSearchViewController else { return }
        if let tagInfo = sender as? Tag {
            areaSearchViewController.tagName = tagInfo.tagName
        }
    }
    
    fileprivate func saveNewTag(_ tagId: String, _ tagName: String) {
        CoreDataManager.shared.saveRecentTag(tagId, tagName)
    }
}

// MARK: - FSPagerViewDataSource
extension HomeViewController: FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.bannerViewModel.countBannerList
    }
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: self.bannerViewModel.bannerInfo(at: index).bannerImageName)
        cell.textLabel?.text = self.bannerViewModel.bannerInfo(at: index).bannerText
        cell.textLabel?.numberOfLines = 2
        return cell
    }
}

// MARK: - FSPagerViewDelegate
extension HomeViewController: FSPagerViewDelegate {
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.myPageControl.currentPage = targetIndex
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.myPageControl.currentPage = pagerView.currentIndex
    }
    
    func pagerView(_ pagerView: FSPagerView, shouldHighlightItemAt index: Int) -> Bool {
        return false
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagViewModel.countTagList
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tagCollectionViewCell", for: indexPath) as? TagCollectionViewCell else {
            return UICollectionViewCell()
        }
        let tagInfo = tagViewModel.tagInfo(at: indexPath.item)
        cell.update(tagInfo: tagInfo)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tagInfo = tagViewModel.tagInfo(at: indexPath.item)
        performSegue(withIdentifier: "homeVCToAreaSearchVC", sender: tagInfo)
        saveNewTag(tagInfo.tagId, tagInfo.tagName)
    }
    
}
