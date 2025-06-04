//
//  ScheduleDataModel.swift
//  F1 app
//
//  Created by Henrique Pacheco on 03/06/2025.
//

import Foundation
import SwiftData


@Model
class ScheduleDataModel{
    var id: Int
    var competition: Competition
    var circuit: Circuit
    var season: Int
    var type: String
    var day: String
    var month: String
    var year: String
    var time: String
    var timezone: String?
    var status: Status?
    
    init(id: Int, competition: Competition, circuit: Circuit, type: String, day: String, month: String, year: String, time: String, timezone: String? = nil, status: Status? = nil) {
        self.id = id
        self.competition = competition
        self.circuit = circuit
        self.type = type
        self.day = day
        self.month = month
        self.year = year
        self.time = time
        self.timezone = timezone
        self.status = status
    }
}

@Model
class Circuit {
    var id: Int
    var name: String
    var location: String
    var country: String
    
    init(id: Int, name: String, location: String, country: String) {
        self.id = id
        self.name = name
        self.location = location
        self.country = country
    }
}

@Model
class Competition {
    var id: Int
    var name: String
    
    init(id: Int, name: String) {
        
        self.id = id
        self.name = name
    }
}
