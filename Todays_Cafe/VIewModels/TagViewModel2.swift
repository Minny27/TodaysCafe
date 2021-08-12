//
//  TagViewModel2.swift
//  Todays_Cafe
//
//  Created by SeungMin on 2021/08/04.
//

import Foundation

final class TagViewModel2 {
    let tagList: [Tag?] = [
        Tag("outdoorSeat", "#야외석 있는"),
        Tag("mood", "#분위기 좋은"),
        Tag("desert", "#디저트가 맛있는"),
        Tag("sweet", "#커피가 맛있는"),
        Tag("quiet", "#작업하기 좋은"),
        Tag("cheap", "#저렴한"),
        Tag("croffle", "#크로플이 맛있는"),
        Tag("roofTop","#루프탑"),
        Tag("refill","#리필가능")
    ]
    
    var countTagList: Int {
        return tagList.count
    }
    
    func tagInfo(at index: Int) -> Tag {
        return tagList[index]!
    }
}
