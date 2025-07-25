//
//  DriverStatsModel.swift
//  F1 app
//
//  Created by Henrique Pacheco on 07/05/2025.
//

import Foundation
import SwiftUI


struct DriverStatsModel {
    
    struct Team {
        let id: Int?
        let name: String?
        let logo: String?
        let color: Color
    }
    
    let id: Int
    let name: String
    let image: String
    let number: Int
    let country: String
    let position: Int
    let points: Int
    let wins: Int
    let total_wins: Int
    let podiums: Int
    let team: Team
    let worldChampionships: Int
    let gpEntries: Int
    
}
