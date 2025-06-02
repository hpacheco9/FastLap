//
//  RaceStandingsEndpoint.swift
//  F1 app
//
//  Created by Henrique Pacheco on 26/05/2025.
//

import Foundation

enum RaceStandingsEndpoint: Endpointable {
    case race(race: String)
    
    var path: String {
        switch self {
        case .race:
            return "/rankings/races"
        }
    }
        
    var parameters: [URLQueryItem]? {
        switch self {
        case let .race(race):
            [URLQueryItem(name: "race", value: race)]
        }
    }
}
