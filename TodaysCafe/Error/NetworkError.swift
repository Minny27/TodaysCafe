//
//  NetworkError.swift
//  Todays_Cafe
//
//  Created by SeungMin on 2021/09/28.
//

import Foundation

enum NetworkError: Error {
    case invalidRequest
    case invalidURL
    case invalidHTML
    case invalidParsing
    case invalidBlogThumbnail
    case invalidBlogerImage
    case invalidBlogerName
    case invalidBlogerUploadDate
    case invalidBlogTitle
    case invalidBlogContetnt
    case invalidBlogDetailUrl
    
}
