//
//  Enumerations.swift
//  F1 app
//
//  Created by Henrique Pacheco on 12/06/2025.
//

import Foundation


enum ScheduleTypes: String, Codable {
    case qualifying_1 = "1st Qualifying"
    case qualifying_2 = "2nd Qualifying"
    case qualifying_3 = "3rd Qualifying"
    case practice_1 = "1st Practice"
    case practice_2 = "2nd Practice"
    case practice_3 = "3rd Practice"
    case race = "Race"
    case sprint = "Sprint"
    case sprint_1 = "1st Sprint Shootout"
    case sprint_2 = "2nd Sprint Shootout"
    case sprint_3 = "3rd Sprint Shootout"

    
    var abreviation: String {
        switch self {
        case .qualifying_1:
            return "Q1"
        case .qualifying_2:
            return "Q2"
        case .qualifying_3:
            return "Q3"
        case .practice_1:
            return "FP1"
        case .practice_2:
            return "FP2"
        case .practice_3:
            return "FP3"
        case .sprint:
            return "Sprint"
        case .sprint_1:
            return "SS1"
        case .sprint_2:
            return "SS2"
        case .sprint_3:
            return "SS3"
        case .race:
            return "Race"
        }
    }
}
