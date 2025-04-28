//
//  RacesAPIModel.swift
//  F1 app
//
//  Created by Henrique Pacheco on 17/04/2025.
//

import Foundation


struct RacesAPIModel: Decodable {
    let id: Int
    let competition: CompetitionAPIModel
    let circuit: CircuitAPIModel
    let season: Int
    let type: String
    let distance: Int
}
