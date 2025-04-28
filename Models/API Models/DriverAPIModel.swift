//
//  DriverAPIModel.swift
//  F1 app
//
//  Created by Henrique Pacheco on 17/04/2025.
//

import Foundation


struct DriverAPIModel: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageUrl = "image"
        case number
        case abbreviation = "abbr"
        
    }
    
    let id: Int
    let name: String
    let abbreviation: String?
    let number: Int
    let imageUrl: String
}
