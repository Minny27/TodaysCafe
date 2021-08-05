//
//  AreaViewModel.swift
//  Todays_Cafe
//
//  Created by SeungMin on 2021/08/06.
//

import Foundation

final class AreaViewModel {
    let areaList: [Tag?] = [
        Tag("강남"),
        Tag("홍대"),
        Tag("신촌"),
        Tag("이태원"),
        Tag("건대"),
        Tag("신사"),
        Tag("이수"),
        Tag("가로수길"),
        Tag("혜화"),
    ]
    
    var countAreaList: Int {
        return areaList.count
    }
    
    func areaInfo(at index: Int) -> Tag {
        return areaList[index]!
    }
}
