//
//  TeamStatsPageViewmodel.swift
//  F1 app
//
//  Created by Henrique Pacheco on 15/05/2025.
//

import Foundation


struct TeamStatsPageViewmodel {
    
    var model: TeamStatsModel
    
    
    var name: String { model.name }
    var logo: String { model.logo }
    var position: String { "\(model.position)" }
    var points: String { "\(model.points)" }
    var wins: String { "\(model.totalWins)" }
    var poles: String { "\(model.poles)" }
    var championships: String { "\(model.championships)" }
    
    

    init(model: TeamStatsModel) {
        self.model = model
    }
}
