//
//  Schedule.swift
//  testev2
//
//  Created by Henrique Pacheco on 10/04/2025.
//

import Foundation

typealias ScheduleAPIResponse = [ScheduleAPIModel]

struct ScheduleAPIModel: Decodable {
    
    struct Parameters: Decodable {
        let season: String
    }
        
    struct Response: Decodable {
        
        struct Laps: Decodable {
            let current: Int?
            let total: Int?
        }

  
        struct FastestLap: Decodable {
            struct Driver: Decodable {
                let id: Int?
            }
            
            let driver: Driver
            let time: String?
        }
        
        let id: Int
        let competition: CompetitionAPIModel
        let circuit: CircuitAPI // Also update reference to use the fixed type name
        let season: Int
        let type: String
        let laps: Laps
        let fastest_lap: FastestLap
        let distance: String?
        let timezone: String
        let date: String?
        let weather: String?
        let status: String?
    }
    
    let get: String?
    let parameters: Parameters
    let errors: [String]
    let results: Int
    let response: [Response?]
}



