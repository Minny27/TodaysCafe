//
//  Tag.swift
//  Todays_Cafe
//
//  Created by SeungMin on 2021/07/22.
//

import Foundation

struct Tag {
    let tagId: String
    let tagName: String
    
    
    init(_ tagId: String, _ tagName: String) {
        self.tagId = tagId
        self.tagName = tagName
    }
}
