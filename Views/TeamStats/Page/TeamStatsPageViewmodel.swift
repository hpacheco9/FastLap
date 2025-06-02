//
//  TeamStatsPageViewmodel.swift
//  F1 app
//
//  Created by Henrique Pacheco on 15/05/2025.
//

import Foundation


class TeamStatsPageViewmodel {
    
    var model: TeamStatsModel
    
   lazy var name: String  = model.name
   lazy var logo: String = model.logo
   lazy var position: Int = model.position
   lazy var points: Int =  model.points
   lazy var wins: String  =  "\(model.totalWins)"
   lazy var poles: String =  "\(model.poles)"
   lazy var championships: String =  "\(model.championships)"
   lazy var fastestLaps: String =  "\(model.fastestLaps)"
    
    

    init(model: TeamStatsModel) {
        self.model = model
    }
}
