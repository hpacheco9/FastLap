//
//  TeamStandingsDataModel.swift
//  F1 app
//
//  Created by Henrique Pacheco on 06/06/2025.
//

import Foundation
import SwiftData

@Model
final class TeamStandingsDataModel {
    
    var position: Int
    var team: Team
    var points: Int
    var season: Int
    
    init(position: Int, team: Team, points: Int, season: Int) {
        self.position = position
        self.team = team
        self.points = points
        self.season = season
    }
}
