//
//  DriverPageViewmodel.swift
//  F1 app
//
//  Created by Henrique Pacheco on 27/05/2025.
//

import Foundation


class DriverPageViewmodel {
    
    var model: DriverModel
    
    lazy var position: Int =  model.position
    lazy var driver: DriverModel.Driver =  model.driver
    lazy var team: DriverModel.Team = model.team
    lazy var points: Int? = model.points
    lazy var wins: Int? = model.wins
    lazy var behind: Int? =  model.behind
    lazy var season: Int =  model.season
    
    init(model: DriverModel) {
        self.model = model
    }   
}
