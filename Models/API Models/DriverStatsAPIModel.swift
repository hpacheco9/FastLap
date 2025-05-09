//
//  DriverStatsAPIModel.swift
//  F1 app
//
//  Created by Henrique Pacheco on 07/05/2025.
//

import Foundation

struct DriverStatsAPIModel: Decodable {
    
    struct Response: Decodable {
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case imageUrl = "image"
            case number
            case grands_prix_entered
            case abbreviation = "abbr"
            case championships = "world_championships"
            case nationality
            case country
            case podiums
            case total_wins = "highest_race_finish"
            case teams
            case career_points
            case highest_grid_position
            case birthdate
            case birthplace
            
        }
        
        struct country: Decodable {
            let name: String
            let code: String
        }
        
        struct wins: Decodable {
            let position: Int
            let number: Int
        }
        
        struct teams: Decodable {
            let season: Int,
            team: TeamAPIModel
        }
        
        
        let id : Int
        let name: String
        let abbreviation: String
        let imageUrl: String
        let nationality: String?
        let country: country
        let birthdate: String
        let birthplace: String
        let number: Int
        let grands_prix_entered: Int?
        let championships: Int?
        let podiums: Int?
        let total_wins: wins
        let highest_grid_position: Int
        let career_points: String
        let teams: [teams]
    }
    
    struct Parameters: Decodable {
        let id: String
    }
    
    let get: String?
    let parameters: Parameters
    let errors: [String]
    let results: Int
    let response: [Response]
    
}
