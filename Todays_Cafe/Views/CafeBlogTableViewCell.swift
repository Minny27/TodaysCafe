//
//  CafeBlogTableViewCell.swift
//  Todays_Cafe
//
//  Created by SeungMin on 2021/08/13.
//

import UIKit
import SwiftSoup

final class CafeBlogTableViewCell: UITableViewCell {
    @IBOutlet weak var blogThumbnail: UIImageView!

    @IBOutlet weak var blogerImage: UIImageView! {
        didSet {
            blogerImage.layer.cornerRadius = blogerImage.layer.frame.height / 2
        }
    }
    @IBOutlet weak var blogerName: UILabel! {
        didSet {
            blogerName.font = .systemFont(ofSize: 10)
        }
    }
    @IBOutlet weak var blogerUploadDate: UILabel! {
        didSet {
            blogerUploadDate.font = .systemFont(ofSize: 10)
        }
    }
    @IBOutlet weak var blogTitle: UILabel! {
        didSet {
            blogTitle.font = .boldSystemFont(ofSize: 13)
        }
    }
    @IBOutlet weak var blogContent: UILabel! {
        didSet {
            blogContent.font = .systemFont(ofSize: 12)
            blogContent.numberOfLines = 2
        }
    }
    
    func update(_ cafeBlogInfo: CafeBlogCellInfo) {
        blogThumbnail.image = cafeBlogInfo.blogThumbnail
        blogerImage.image = cafeBlogInfo.blogerImage
        blogerName.text = cafeBlogInfo.blogerName
        blogerUploadDate.text = cafeBlogInfo.blogerUploadDate
        blogTitle.text = cafeBlogInfo.blogTitle
        blogContent.text = cafeBlogInfo.blogContetnt
    }
}
