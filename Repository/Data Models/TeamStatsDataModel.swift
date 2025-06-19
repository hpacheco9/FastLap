//
//  TeamStatsDataModel.swift
//  F1 app
//
//  Created by Henrique Pacheco on 12/06/2025.
//

import Foundation
import SwiftData


@Model
final class TeamStatsDataModel {
    
    var id: Int
    var name: String
    var logo: String
    var position: Int
    var points: Int
    var wins: Int
    var poles: Int
    var championships: Int
    var fastestLaps: Int
    
    init(id: Int, name: String, logo: String, position: Int, points: Int, wins: Int, poles: Int, championships: Int, fastestLaps: Int) {
        self.id = id
        self.name = name
        self.logo = logo
        self.position = position
        self.points = points
        self.wins = wins
        self.poles = poles
        self.championships = championships
        self.fastestLaps = fastestLaps
    }
}


extension TeamStatsDataModel: AssetForTeam {}


