//
//  BannerViewModel.swift
//  Todays_Cafe
//
//  Created by SeungMin on 2021/07/27.
//

import Foundation

final class BannerViewModel {
    let bannerList: [Banner?] = [
        Banner("솔직 담백한 카페 리뷰를 바탕으로\n나만의 카페를 추천해드립니다.", "a.jpg"),
        Banner("우리 서비스가 짱이에요!!", "b.jpg"),
        Banner("무~야~호!", "c.jpg")
    ]
    
    var countBannerList: Int {
        return self.bannerList.count
    }
    
    func bannerInfo(at index: Int) -> Banner {
        return bannerList[index]!
    }
}
