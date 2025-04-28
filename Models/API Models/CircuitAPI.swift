//
//  CircuitAPI.swift
//  F1 app
//
//  Created by Henrique Pacheco on 28/04/2025.
//

import Foundation

struct CircuitAPI: Decodable {
    
        let id: Int
        let name: String
        let image: String
}

extension CircuitAPI: CircuitAsset {}
