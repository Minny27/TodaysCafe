//
//  RecentSearchThemaViewModel.swift
//  Todays_Cafe
//
//  Created by SeungMin on 2021/09/02.
//

import Foundation

final class RecentSearchThemaViewModel {
    var themaList: [RecentSearchTag?] = []
    
    var countThemaList: Int {
        return themaList.count
    }
    
    func themaInfo(at index: Int) -> RecentSearchTag {
        return themaList[index]!
    }
    
    func appendThema(_ themaInfo: RecentSearchTag) {
        themaList.append(themaInfo)
    }
}
