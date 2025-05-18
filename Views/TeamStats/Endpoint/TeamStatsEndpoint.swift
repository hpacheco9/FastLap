//
//  TeamStatsEndpoint.swift
//  F1 app
//
//  Created by Henrique Pacheco on 14/05/2025.
//

import Foundation


enum TeamStatsEndpoint: Endpointable {
    
    case team (id: String)
    
    var path: String {
        switch self {
        case .team:
            return "/teams"
        }
    }
        
    var parameters: [URLQueryItem]? {
        switch self {
        case let .team(id):
            [URLQueryItem(name: "id", value: id)]
        }
    }
    
}
