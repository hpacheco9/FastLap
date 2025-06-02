//
//  TeamPageViewmodel.swift
//  F1 app
//
//  Created by Henrique Pacheco on 27/05/2025.
//

import Foundation

class TeamPageViewmodel {
    
    var model: TeamModel
    
    lazy var id: Int = model.id
    lazy var name: String = model.name
    
    lazy var points: Int = model.points
    lazy var position: Int = model.position
    lazy var logo: String = model.logo 
    
    
    
    
    
    
    init(model: TeamModel) {
        self.model = model
    }
}
