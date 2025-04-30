//
//  ScheduleEndpoint.swift
//  F1 app
//
//  Created by Henrique Pacheco on 29/04/2025.
//

import Foundation


enum ScheduleEndpoint: Endpointable {
    case schedule (season: String)
    
    var path: String {
        switch self {
        case .schedule:
            return "/races"
        }
    }
        
    var parameters: [URLQueryItem]? {
        switch self {
        case let .schedule(season):
            [URLQueryItem(name: "season", value: season)]
        }
    }
}
