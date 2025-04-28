//
//  RankingsAPIModel.swift
//  F1 app
//
//  Created by Henrique Pacheco on 17/04/2025.
//

import Foundation

typealias RankingsAPIResponse = [RankingsAPIModel]

struct RankingsAPIModel: Decodable {
    
    struct Parameters: Decodable {
        let season: String
    }
    
    struct Response: Decodable {
        let position: Int
        let driver: DriverAPIModel
        let team: TeamAPIModel
        let points: Int?
        let wins: Int
        let behind: Int?
        let season: Int
    }
    
    let get: String?
    let parameters: Parameters
    let errors: [String]
    let results: Int
    let response: [Response]
   
}
