//
//  ViewController.swift
//  Todays_Cafe
//
//  Created by SeungMin on 2021/07/16.
//

import UIKit
import FSPagerView

class ViewController: UIViewController, FSPagerViewDataSource, FSPagerViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource {
    
    let bannerViewModel = BannerViewModel()
    let tagViewModel = TagViewModel()
    let searchViewModel = SearchViewModel()
    
    @IBOutlet weak var myPagerView: FSPagerView! {
        didSet {
            self.myPagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.myPagerView.itemSize = FSPagerViewAutomaticSize
            self.myPagerView.automaticSlidingInterval = 4.0
//            self.myPagerView.isInfinite = true
        }
    }
    
    @IBOutlet weak var myPageControl: FSPageControl! {
        didSet {
            self.myPageControl.numberOfPages = self.bannerViewModel.countBannerList
            self.myPageControl.contentHorizontalAlignment = .center
            self.myPageControl.itemSpacing = 15
//            self.myPageControl.backgroundColor = .gray
//            self.myPageControl.interitemSpacing = 16
        }
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myPagerView.dataSource = self
        self.myPagerView.delegate = self
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.bannerViewModel.countBannerList
    }
    
    // MARK: - PagerView
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: self.bannerViewModel.bannerInfo(at: index).bannerImageName)
        cell.textLabel?.text = self.bannerViewModel.bannerInfo(at: index).bannerText
        cell.textLabel?.numberOfLines = 2
        return cell
    }

    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.myPageControl.currentPage = targetIndex
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.myPageControl.currentPage = pagerView.currentIndex
    }
    
    func pagerView(_ pagerView: FSPagerView, shouldHighlightItemAt index: Int) -> Bool {
        return false
    }
    
    // MARK: - CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagViewModel.countTagList
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as?  CollectionViewCell else {
            return UICollectionViewCell()
        }
        let tagInfo = tagViewModel.tagInfo(at: indexPath.item)
        cell.update(tagInfo: tagInfo)
        return cell
    }
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel.countSearchTextList
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }

        let searchInfo = searchViewModel.SearchTextInfo(at: indexPath.row)
        cell.update(searchInfo: searchInfo)
        return cell
    }
}

