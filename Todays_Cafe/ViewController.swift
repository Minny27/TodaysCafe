//
//  ViewController.swift
//  Todays_Cafe
//
//  Created by SeungMin on 2021/07/16.
//

import UIKit
import FSPagerView

class ViewController: UIViewController, FSPagerViewDataSource, FSPagerViewDelegate {
    
    fileprivate let imageNmaes = ["a.jpg", "b.jpg", "c.jpg"]
    private let text = ["솔직 담백한 카페 리뷰를 바탕으로\n나만의 카페를 추천해드립니다.", "우리 서비스가 짱이에요!!", "무~야~호!"]
    
    
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
            self.myPageControl.numberOfPages = self.imageNmaes.count
            self.myPageControl.contentHorizontalAlignment = .center
            self.myPageControl.itemSpacing = 15
//            self.myPageControl.interitemSpacing = 16

        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print( "ViewController - viewDidLoad() called")
        self.myPagerView.dataSource = self
        self.myPagerView.delegate = self
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return imageNmaes.count
    }
    

    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        print( "ViewController - pagerView() called")
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: self.imageNmaes[index])
        cell.imageView?.contentMode = .scaleAspectFill
        cell.textLabel?.text = text[index]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.backgroundColor = .clear

        
        return cell
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.myPageControl.currentPage = pagerView.currentIndex
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.myPageControl.currentPage = myPagerView.currentIndex
    }
    
    func pagerView(_ pagerView: FSPagerView, shouldHighlightItemAt index: Int) -> Bool {
        return false
    }


}

