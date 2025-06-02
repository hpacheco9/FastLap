//
//  RaceRankingsAPIModel.swift
//  F1 app
//
//  Created by Henrique Pacheco on 26/05/2025.
//

import Foundation

struct RaceRankingsAPIModel: Decodable {
    
    struct Parameters: Decodable {
        let race: String
    }
    
    struct Response: Decodable {
        struct Race: Decodable {
            let id : Int
        }
        
        let race: Race
        let driver: DriverAPIModel
        let team: TeamAPIModel
        let position: Int
        let time: String
        let laps: Int
        let grid: String
        let pits: Int
        let gap: String?
        
    }
    
    let get: String?
    let parameters: Parameters
    let errors: [String]
    let results: Int
    let response: [Response]
}
