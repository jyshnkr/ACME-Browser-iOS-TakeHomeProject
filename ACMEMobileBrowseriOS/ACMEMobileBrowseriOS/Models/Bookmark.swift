//
//  Bookmark.swift
//  ACMEMobileBrowseriOS
//
//  Created by JayaShankar Mangina on 4/15/22.
//

import Foundation

struct Bookmark: Codable, Equatable{
    
    let url: URL
    
    let urlNameTitle: String
    
    static func == (left: Bookmark, right: Bookmark) -> Bool {
        return left.url == right.url
    }
    
}
