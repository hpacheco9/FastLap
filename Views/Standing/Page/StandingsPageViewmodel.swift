//
//  StandingsViewmodel.swift
//  F1 app
//
//  Created by Henrique Pacheco on 03/05/2025.
//

import Foundation


struct StandingsPageViewmodel {
    
    var model: DriverModel
    
    var position: Int { model.position }
    var driver: DriverModel.Driver { model.driver }
    var team: DriverModel.Team { model.team }
    var points: Int? { model.points}
    var wins: Int? { model.wins }
    var behind: Int? { model.behind }
    var season: Int { model.season }
    
    
    init(model: DriverModel) {
        self.model = model
    }   
}
