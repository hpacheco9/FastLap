//
//  ScheduleModel.swift
//  F1 app
//
//  Created by Henrique Pacheco on 28/04/2025.
//

import Foundation

struct ScheduleModel {
    
    struct Competition {
        struct Location {
            let country: String
            let city: String
        }
        
        let id: Int
        let name: String
        let location: Location
    }
    
    struct Circuit {
        
        let id: Int
        let name: String
        let image: String
    }
    
    
    let id: Int
    let competition: Competition
    let circuit: Circuit
    let type: String
    let day: String
    let month: String
    let year: String
    let time: String
    let timezone: String?
    let status: Status?
    
}
