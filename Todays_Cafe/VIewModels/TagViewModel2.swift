//
//  TagSearchViewModel.swift
//  Todays_Cafe
//
//  Created by SeungMin on 2021/08/02.
//

import UIKit

final class TagViewModel2 {
    let tagList: [Tag?] = [
        Tag("#야외석 있는"),
        Tag("#분위기 좋은"),
        Tag("#디저트가 맛있는"),
        Tag("#커피가 맛있는"),
        Tag("#작업하기 좋은"),
        Tag("#저렴한"),
        Tag("#핸드드립"),
        Tag("#크로플이 맛있는"),
        Tag("#리필가능")
    ]
    
    var countTagList: Int {
        return tagList.count
    }
    
    func tagInfo(at index: Int) -> Tag {
        return tagList[index]!
    }
}
