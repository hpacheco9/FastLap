//
//  StandingsDataModel.swift
//  F1 app
//
//  Created by Henrique Pacheco on 03/06/2025.
//

import Foundation
import SwiftData
import SwiftUI


@Model
final class StandingDataModel {
    
    var position: Int
    @Relationship var driver: Driver
    @Relationship var team: Team
    var points: Int?
    var wins: Int
    var behind: Int?
    var season: Int
    
    init(position: Int, driver: Driver, team: Team, points: Int? = nil, wins: Int, behind: Int? = nil, season: Int) {
        self.position = position
        self.driver = driver
        self.team = team
        self.points = points
        self.wins = wins
        self.behind = behind
        self.season = season
    }
}

@Model
final class Driver {
    var id: Int
    var name: String
    var abbreviation: String?
    var number: Int
    var imageUrl: String
    
    init(id: Int, name: String, abbreviation: String? = nil, number: Int, imageUrl: String) {
        self.id = id
        self.name = name
        self.abbreviation = abbreviation
        self.number = number
        self.imageUrl = imageUrl
    }
}

@Model
final class Team {
    var id: Int
    var name: String
    var logo: String
    var color: Color
    
    init(id: Int, name: String, logo: String, color: Color) {
        self.id = id
        self.name = name
        self.logo = logo
        self.color = color
    }
}

