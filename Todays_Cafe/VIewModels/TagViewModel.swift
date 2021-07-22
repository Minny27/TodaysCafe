//
//  TagViewModel.swift
//  Todays_Cafe
//
//  Created by SeungMin on 2021/07/22.
//

import Foundation

final class TagViewModel {
    let tagList: [Tag?] = [
        Tag("#야외석 있는"),
        Tag("#분위기 좋은"),
        Tag("#디저트가 맛있는"),
        Tag("#커피가 맛있는"),
        Tag("#작업하기 좋은"),
        Tag("#저렴한")
    ]
    
    var countTagList: Int {
        return tagList.count
    }
    
    func tagInfo(at index: Int) -> Tag {
        return tagList[index]!
    }
}
