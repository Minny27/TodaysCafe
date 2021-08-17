//
//  CafeBlogCellInfo.swift
//  Todays_Cafe
//
//  Created by SeungMin on 2021/08/12.
//

import Foundation
import SwiftSoup

struct CafeBlogCellInfo {
    let blogThumbnail: UIImage
    let blogerImage: UIImage
    let blogerName: String
    let blogerUploadDate: String
    let blogTitle: String
    let blogContetnt: String
    
    init(_ blogThumbnail: UIImage, _ blogerImage: UIImage, _ blogerName: String, _ blogerUploadDate: String, _ blogTitle: String, _ blogContetnt: String) {
        self.blogThumbnail = blogThumbnail
        self.blogerImage = blogerImage
        self.blogerName = blogerName
        self.blogerUploadDate = blogerUploadDate
        self.blogTitle = blogTitle
        self.blogContetnt = blogContetnt
    }
}
