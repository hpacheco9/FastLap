//
//  CircuitAPIModel.swift
//  F1 app
//
//  Created by Henrique Pacheco on 17/04/2025.
//

import Foundation


struct CircuitAPIModel: Decodable {
    
    let id: Int
    let name: String
    let image: String
    let competion: CompetitionAPIModel
    let first_grand_prix: Int
    let laps: Int
    let length: String
    let race_distance: String
    let lap_record: LapRecordAPIModel
    let capicity: Int
    let opened: Int
    
}
