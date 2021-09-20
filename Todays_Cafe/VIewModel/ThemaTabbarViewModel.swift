//
//  ThemaTabbarViewModel.swift
//  Todays_Cafe
//
//  Created by SeungMin on 2021/09/02.
//

import Foundation

final class ThemaTabbarViewModel {
    let themaList: [Tag?] = [
        Tag("recommendation", "추천 테마"),
        Tag("recentSearch", "최근 검색 테마"),
    ]
    
    var countThemaList: Int {
        return themaList.count
    }
    
    func themaInfo(at index: Int) -> Tag {
        return themaList[index]!
    }
}
