//
//  SchedulePageViewmodel.swift
//  F1 app
//
//  Created by Henrique Pacheco on 08/05/2025.
//

import Foundation


struct SchedulePageViewmodel {
    
    
    var model: ScheduleModel
    
    
    var id: Int { model.id }
    
    var country: String { model.competition.location.country }
    
    var circuitId: Int { model.circuit.id }
    var circuitName: String { model.circuit.name }
    var circuitImage: String { model.circuit.image }
    
    var day: String { model.day }
    var month: String { model.month }
    var time: String { model.time }
    
    var comperitionId: Int { model.competition.id }
    
    var competitionName: String { model.competition.name }
    
    var type: String { model.type }
    
    init(model: ScheduleModel) {
        self.model = model
    }
    
   
}
