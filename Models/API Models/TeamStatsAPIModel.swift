//
//  TeamStatsAPIModel.swift
//  F1 app
//
//  Created by Henrique Pacheco on 14/05/2025.
//

import Foundation


struct TeamStatsAPIModel: Decodable {
    
    struct Parameters: Decodable {
        let id: String
    }
    
    struct highestRaceWins: Decodable {
        let position: Int
        let number: Int
    }
    
    
    struct Response: Decodable {
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case logo
            case base
            case firstEntry = "first_team_entry"
            case championships = "world_championships"
            case totalWins = "highest_race_finish"
            case totalPoles = "pole_positions"
            case totalFastestLaps =  "fastest_laps"
            case director
            case techincalManager = "technical_manager"
            case president
            case chassis
            case engine
            case tyres  
        }
        
        let id: Int
        let name: String
        let logo: String
        let base: String
        let firstEntry: Int
        let championships: Int
        let totalWins: highestRaceWins
        let totalPoles: Int?
        let totalFastestLaps: Int?
        let president: String?
        let director: String?
        let techincalManager: String?
        let chassis: String?
        let engine: String?
        let tyres: String?
        
        
    }
    
    let get: String?
    let parameters: Parameters
    let errors: [String]
    let results: Int
    let response: [Response]
    
    
}


extension TeamStatsAPIModel.Response : Cenas {}


