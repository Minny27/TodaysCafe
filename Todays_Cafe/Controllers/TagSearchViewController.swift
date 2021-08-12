//
//  SearchController.swift
//  Todays_Cafe
//
//  Created by SeungMin on 2021/07/31.
//

import UIKit

class TagSearchViewController: UIViewController {
    let tagViewModel2 = TagViewModel2()
    let tagCollectionViewCell2 = TagCollectionViewCell2()
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let areaSearchViewController = segue.destination as? AreaSearchViewController else { return }
        if let tagInfo = sender as? Tag {
            areaSearchViewController.tagName = tagInfo.tagName
        }
    }
    
    @IBAction func onBackBtnClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onRecommendTagBtnClicked(_ sender: UIButton) {
    }
    
    
    @IBAction func onRecentSearchTagBtnClicked(_ sender: Any) {
    }
}

// MARK: - UICollectionViewDataSource
extension TagSearchViewController: UICollectionViewDataSource {
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

// MARK: - UICollectionViewDelegate
extension TagSearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tagInfo = tagViewModel2.tagInfo(at: indexPath.item)
        performSegue(withIdentifier: "tagSearchVCToAreaSearchVC", sender: tagInfo)
    }
}
