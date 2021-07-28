//
//  Banner.swift
//  Todays_Cafe
//
//  Created by SeungMin on 2021/07/27.
//

import Foundation

struct Banner {
    let bannerText: String
    let bannerImageName: String
    
    init(_ bannerText: String, _ bannerImageName: String) {
        self.bannerText = bannerText
        self.bannerImageName = bannerImageName
    }
}
