//
//  GyeonggiAreaViewModel.swift
//  Todays_Cafe
//
//  Created by SeungMin on 2021/08/31.
//

import Foundation

final class GyeonggiAreaViewModel {
    let gyeonggiAreaList: [Tag?] = [
        Tag("suwon", "수원"),
        Tag("seongnam", "성남"),
        Tag("anyang", "안양"),
        Tag("bucheon", "부천"),
        Tag("goyang", "고양"),
        Tag("namyangju", "남양주"),
        Tag("yongin", "용인"),
        Tag("hanam", "하남"),
        Tag("pyeongtaek", "평택")
    ]
    
    var countGyeonggiAreaList: Int {
        return gyeonggiAreaList.count
    }
    
    func gyeonggiAreaInfo(at index: Int) -> Tag {
        return gyeonggiAreaList[index]!
    }
}
