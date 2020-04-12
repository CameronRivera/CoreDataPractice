//
//  PixModel.swift
//  CoreDataLab
//
//  Created by Cameron Rivera on 4/8/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import Foundation

struct PixWrapper: Codable{
    let hits: [PixPic]
}

struct PixPic: Codable{
    let id: Int
    let type: String
    let tags: String
    let largeImageURL: String
    let views: Int
    let likes: Int
    let downloads: Int
    let favorites: Int
}
