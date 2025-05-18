//
//  DriverProfilePageViewmodel.swift
//  F1 app
//
//  Created by Henrique Pacheco on 08/05/2025.
//

import Foundation


struct DriverProfilePageViewmodel {
    var model: DriverStatsModel
    
    var name: String {
        model.name
    }
    
    var number: String {
        String(model.number)
    }
    
    var teamLogo: String {
        model.team.logo ?? ""
    }
    var teamName: String {
        model.team.name ?? ""
    }
    
    var image: String {
        model.image
    }
    
    var worldChampionships: Int {
        model.worldChampionships
    }
    
    var podiums: Int {
        model.podiums
    }
    
    var gpEntries: Int {
        model.gpEntries
    }
    
    var total_wins: Int {
        model.wins
    }
    
    var points: Int {
        model.points
    }
    
    var position: Int {
        model.position
    }
    
    var wins: Int {
        model.wins
    }
    
    init (model: DriverStatsModel) {
        self.model = model
    }
}
