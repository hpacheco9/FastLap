//
//  LapRecordAPIModel.swift
//  F1 app
//
//  Created by Henrique Pacheco on 17/04/2025.
//

import Foundation

struct LapRecordAPIModel: Decodable {
    let time: String
    let driver: String
    let year: String
}
