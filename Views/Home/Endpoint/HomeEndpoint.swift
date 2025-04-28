//
//  HomeEndpoint.swift
//  testev2
//
//  Created by Henrique Pacheco on 10/04/2025.
//

import Foundation


enum HomeEndpoint: Endpointable {
    
    case rankings (season: String)
    case schedule (season: String)
    
    
    var path: String {
        switch self {
        case .rankings:
            return "/rankings/drivers"
        case .schedule:
            return "/races"
        }
    }
        

    var parameters: [URLQueryItem]? {
        switch self {
        case let .rankings(season), let .schedule(season):
            [URLQueryItem(name: "season", value: season)]
        }
    }
}







