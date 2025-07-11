//
//  DriverProfilePageViewmodel.swift
//  F1 app
//
//  Created by Henrique Pacheco on 08/05/2025.
//

import Foundation

class DriverProfilePageViewmodel {
    
    var model: DriverStatsModel
    
    lazy var name: String = model.name
    
    lazy var number: String  = String(model.number)
    
    lazy var teamLogo: String = model.team.logo ?? ""
    
    lazy var teamName: String = model.team.name ?? ""
    
    lazy var image: String = model.image
    
    lazy var worldChampionships: Int  = model.worldChampionships
    
    lazy var podiums: Int = model.podiums
    
    lazy var gpEntries: Int  = model.gpEntries
    
    lazy var total_wins: Int  = model.total_wins
    
    lazy var points: Int = model.points
    
    lazy var position: Int = model.position
    
    lazy var wins: Int = model.wins
    
    
    init (model: DriverStatsModel) {
        self.model = model
    }
}
