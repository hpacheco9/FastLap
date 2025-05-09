//
//  DriverStatsModel.swift
//  F1 app
//
//  Created by Henrique Pacheco on 07/05/2025.
//

import Foundation


struct DriverStatsModel {
    
    
    
    struct Team: Cenas {
        let id: Int
        let name: String
        let logo: String
    }

    
    let id: Int
    let name: String
    let image: String
    let number: Int
    let country: String
    let position: Int
    let points: Int
    let wins: Int
    let podiums: Int
    let team: Team
    let worldChampionships: Int
    let gpEntries: Int

    
    
    
    
}
