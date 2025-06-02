//
//  RaceStandingsPageViewmodel.swift
//  F1 app
//
//  Created by Henrique Pacheco on 26/05/2025.
//

import Foundation
import SwiftUI


class RaceStandingsPageViewmodel {
    
    var model: RaceStandings
    
    lazy var id: Int = model.id
    lazy var name: String = model.name
    lazy var color: Color = model.color
    lazy var position: String = String(model.position)
    lazy var abbreviation: String = model.abbreviation
    lazy var time : String = model.time
    
    
    init(model: RaceStandings) {
        self.model = model
    }
}
