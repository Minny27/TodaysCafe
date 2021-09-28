//
//  areaSearchController.swift
//  Todays_Cafe
//
//  Created by SeungMin on 2021/07/31.
//

import UIKit

class AreaSearchViewController: UIViewController {
    let cityTabbarViewModel = CityTabbarViewModel()
    var seoulAreaViewModel = SeoulAreaViewModel()
    var gyeonggiAreaViewModel = GyeonggiAreaViewModel()
    var incheonAreaViewModel = IncheonAreaViewModel()
    var tagName: String?
    var cityNmae: String = ""
    var checkCityHashTable: [String: Int] = ["seoul": 1, "gyeonggi": 0, "incheon": 0]
    
    @IBOutlet weak var cityTabbarCollecionView: UICollectionView!
    
    @IBOutlet weak var areaCollectionView: UICollectionView! {
        didSet {
            self.areaCollectionView.layer.borderWidth = 1.5
            self.areaCollectionView.layer.borderColor = UIColor.lightGray.cgColor
            self.areaCollectionView.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            self.backButton.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
            self.backButton.contentHorizontalAlignment = .fill
            self.backButton.contentVerticalAlignment = .fill
            self.backButton.tintColor = .darkGray
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityTabbarCollecionView.dataSource = self
        cityTabbarCollecionView.delegate = self
        areaCollectionView.dataSource = self
        areaCollectionView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cafeBlogTableViewController = segue.destination as? CafeBlogTableViewController else { return }
        cafeBlogTableViewController.cityName = cityNmae
        
        if let areaInfo = sender as? Tag {
            cafeBlogTableViewController.areaName = areaInfo.tagName
        }
        if let tagName = self.tagName {
            cafeBlogTableViewController.tagName = tagName
        }
    }
    
    @IBAction func onBackButtonClicked(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource
extension AreaSearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == cityTabbarCollecionView {
            return cityTabbarViewModel.countCityList
        }
        else {
            if checkCityHashTable["seoul"] == 1 {
                return seoulAreaViewModel.countSeoulAreaList
            }
            else if checkCityHashTable["gyeonggi"] == 1 {
                return gyeonggiAreaViewModel.countGyeonggiAreaList
            }
            else {
                return incheonAreaViewModel.countIncheonAreaList
            }
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == cityTabbarCollecionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cityTabbarCollecionViewCell", for: indexPath) as? CityTabbarCollecionViewCell else {
                return UICollectionViewCell()
            }
            let cityInfo = cityTabbarViewModel.cityInfo(at: indexPath.item)
            cell.update(cityInfo: cityInfo)
            return cell
        }
        else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "areaCollectionViewCell", for: indexPath) as? AreaCollectionViewCell else {
                return UICollectionViewCell()
            }
            if checkCityHashTable["seoul"] == 1 {
                let areaInfo = seoulAreaViewModel.seoulAreaInfo(at: indexPath.item)
                cell.update(areaInfo: areaInfo)
                return cell
            }
            else if checkCityHashTable["gyeonggi"] == 1 {
                let areaInfo = gyeonggiAreaViewModel.gyeonggiAreaInfo(at: indexPath.item)
                cell.update(areaInfo: areaInfo)
                return cell
            }
            else {
                let areaInfo = incheonAreaViewModel.incheonAreaInfo(at: indexPath.item)
                cell.update(areaInfo: areaInfo)
                return cell
            }
        }
    }
}

// MARK: - UICollectionViewDelegate
extension AreaSearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == cityTabbarCollecionView {
            var checkCityHashTableCache = checkCityHashTable
            let cityInfo = cityTabbarViewModel.cityInfo(at : indexPath.item)
            
            if cityInfo.tagId == "seoul" {
                checkCityHashTableCache["seoul"] = 1
                checkCityHashTableCache["gyeonggi"] = 0
                checkCityHashTableCache["incheon"] = 0
            }
            else if cityInfo.tagId == "gyeonggi" {
                checkCityHashTableCache["seoul"] = 0
                checkCityHashTableCache["gyeonggi"] = 1
                checkCityHashTableCache["incheon"] = 0
            }
            else {
                checkCityHashTableCache["seoul"] = 0
                checkCityHashTableCache["gyeonggi"] = 0
                checkCityHashTableCache["incheon"] = 1
            }
            
            if checkCityHashTableCache != checkCityHashTable {
                checkCityHashTable = checkCityHashTableCache
                areaCollectionView.reloadData()
            }
        }
        
        else {
            if checkCityHashTable["seoul"] == 1 {
                cityNmae = "서울"
                let areaInfo = seoulAreaViewModel.seoulAreaInfo(at: indexPath.item)
                performSegue(withIdentifier: "areaSearchVCToCafeBlogTableVC", sender: areaInfo)
            }
            else if checkCityHashTable["gyeonggi"] == 1 {
                cityNmae = "경기도"
                let areaInfo = gyeonggiAreaViewModel.gyeonggiAreaInfo(at: indexPath.item)
                performSegue(withIdentifier: "areaSearchVCToCafeBlogTableVC", sender: areaInfo)
            }
            else {
                cityNmae = "인천"
                let areaInfo = incheonAreaViewModel.incheonAreaInfo(at: indexPath.item)
                performSegue(withIdentifier: "areaSearchVCToCafeBlogTableVC", sender: areaInfo)
            }
        }
    }
}
