//
//  AreaTabbarViewModel.swift
//  Todays_Cafe
//
//  Created by SeungMin on 2021/08/30.
//

import Foundation

final class CityTabbarViewModel {
    let cityList: [Tag?] = [
        Tag("seoul", "서울"),
        Tag("gyeonggi", "경기"),
        Tag("incheon", "인천"),
    ]
    
    var countCityList: Int {
        return cityList.count
    }
    
    func cityInfo(at index: Int) -> Tag {
        return cityList[index]!
    }
}
