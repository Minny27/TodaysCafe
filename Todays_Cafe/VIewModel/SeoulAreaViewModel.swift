//
//  AreaViewModel.swift
//  Todays_Cafe
//
//  Created by SeungMin on 2021/08/06.
//

import Foundation

final class SeoulAreaViewModel {
    let seoulAreaList: [Tag?] = [
        Tag("gangnam", "강남"),
        Tag("hongUni", "홍대"),
        Tag("hongUni", "신촌"),
        Tag("konUni", "건대"),
        Tag("garosugil", "가로수길"),
        Tag("sinsa", "신사"),
        Tag("apgujeong", "압구정"),
        Tag("hyehwa", "혜화"),
        Tag("itaewon", "이태원")
    ]
    
    var countSeoulAreaList: Int {
        return seoulAreaList.count
    }
    
    func seoulAreaInfo(at index: Int) -> Tag {
        return seoulAreaList[index]!
    }
}
