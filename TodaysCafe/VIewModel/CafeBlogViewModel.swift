//
//  CafeBlogTableViewModel.swift
//  Todays_Cafe
//
//  Created by SeungMin on 2021/08/13.
//

import Foundation

final class CafeBlogViewModel {
    var cafeBlogList: [CafeBlogCellInfo] = []
    
    var countCafeBlogList: Int {
        return cafeBlogList.count
    }
    
    func cafeBlogInfo(at index: Int) -> CafeBlogCellInfo {
        return cafeBlogList[index]
    }
    
    func appendCafeBlog(_ cafeBlogCellInfo: CafeBlogCellInfo) {
        cafeBlogList.append(cafeBlogCellInfo)
    }
}
