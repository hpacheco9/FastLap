//
//  DriverEndpoint.swift
//  F1 app
//
//  Created by Henrique Pacheco on 07/05/2025.
//

import Foundation

enum DriverEndpoint: Endpointable {
    
    case driver (id: String)
    
    var path: String {
        switch self {
        case .driver:
            return "/drivers"
        }
    }
        
    var parameters: [URLQueryItem]? {
        switch self {
        case let .driver(id):
            [URLQueryItem(name: "id", value: id)]
        }
    }
}
