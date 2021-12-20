//
//  IncheonAreaViewModel.swift
//  Todays_Cafe
//
//  Created by SeungMin on 2021/08/31.
//

import Foundation

final class IncheonAreaViewModel {
    let incheonAreaList: [Tag?] = [
        Tag("jung-gu", "중구"),
        Tag("dong-gu", "동구"),
        Tag("yeonsu-gu", "연수구"),
        Tag("namdong-gu", "남동구"),
        Tag("seo-gu", "서구"),
        Tag("gyeyang", "계양"),
        Tag("bupyeong", "부평"),
        Tag("ganghwa", "강화"),
        Tag("michuhol-gu", "미추홀구")
    ]
    
    var countIncheonAreaList: Int {
        return incheonAreaList.count
    }
    
    func incheonAreaInfo(at index: Int) -> Tag {
        return incheonAreaList[index]!
    }
}
