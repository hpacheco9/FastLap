//
//  StandingsEndpoint.swift
//  F1 app
//
//  Created by Henrique Pacheco on 29/04/2025.
//

import Foundation

enum StandingsEndpoint: Endpointable {
    
    case drivers (season: String)
    case teams (season: String)
    
    
    var path: String {
        switch self {
        case .drivers:
            return "/rankings/drivers"
        case .teams:
            return "/rankings/teams"
        }
    }
    
    var parameters: [URLQueryItem]? {
        switch self {
        case let .drivers(season), let .teams(season):
            [URLQueryItem(name: "season", value: season)]
        }
    }
    
}
