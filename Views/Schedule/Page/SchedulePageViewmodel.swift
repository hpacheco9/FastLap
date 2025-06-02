//
//  SchedulePageViewmodel.swift
//  F1 app
//
//  Created by Henrique Pacheco on 08/05/2025.
//

import Foundation


class SchedulePageViewmodel {
    
    
    var model: ScheduleModel
    
    
    var id: Int { model.id }
    
    lazy var country: String = model.competition.location.country
    
    lazy var circuitId: Int =  model.circuit.id
    lazy var circuitName: String =  model.circuit.name
    lazy var circuitImage: String = model.circuit.image
    
    lazy var day: String = model.day
    lazy var month: String =  model.month
    lazy var year: String =  model.year
    lazy var time: String =  model.time
    
    
    lazy var competionId: Int = model.competition.id
    
    lazy var competitionName: String = model.competition.name
    
    lazy var type: String =  model.type
    
    lazy var status: Status? =  model.status 
    
    init(model: ScheduleModel) {
        self.model = model
    }
    
   
}
