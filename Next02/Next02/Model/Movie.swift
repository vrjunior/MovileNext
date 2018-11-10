//
//  Movie.swift
//  Next02
//
//  Created by Valmir Junior on 03/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import Foundation


enum ItemType: String, Codable {
    case movie
    case list
}


struct Movie: Codable {
    
    let title: String
    let categories: [String]?
    let duration: String?
    let rating: Float?
    let sinopse: String?
    let image: String?
    let itemType: ItemType?
    let items: [Movie]?
    
    
    enum CodingKeys: String, CodingKey {
        case title
        case categories
        case duration
        case rating
        case sinopse = "description"
        case image
        case itemType
        case items
    }
}

