//
//  TeamRankingsAPIModel.swift
//  F1 app
//
//  Created by Henrique Pacheco on 29/04/2025.
//

import Foundation


struct TeamRankingsAPIModel: Decodable {
    
    
    struct Response: Decodable {
        
      
        
        let position: Int
        let team: TeamAPIModel
        let points: Int
        let season: Int
    }
    
    struct Parameters: Decodable {
        let season: String
    }
    
    
    let get: String?
    let parameters: Parameters
    let errors: [String]
    let results: Int
    let response: [Response]
    
    
}
