//
//  ScheduleDataModel.swift
//  F1 app
//
//  Created by Henrique Pacheco on 03/06/2025.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class ScheduleDataModel {
    var id: Int
    var competition: Competition
    var circuit: Circuit
    var season: Int
    var type: ScheduleTypes
    var date: String?
    var timezone: String?
    var status: Status?
    
    init(id: Int, competition: Competition, circuit: Circuit, season: Int, type: ScheduleTypes, date: String? = nil, timezone: String?, status: Status) {
        self.id = id
        self.competition = competition
        self.circuit = circuit
        self.season = season
        self.type = type
        self.date = date
        self.timezone = timezone
        self.status = status
    }
}
struct Circuit: Codable, CircuitAsset {
    var id: Int
    var name: String
    var image: String
}

struct Competition: Codable {
    struct Location: Codable {
        var country: String
        var city: String
    }

    var id: Int
    var name: String
    var location: Location
}
