//
//  TeamAPIModel.swift
//  F1 app
//
//  Created by Henrique Pacheco on 17/04/2025.
//

import Foundation


struct TeamAPIModel: Decodable {
    let id: Int
    let name: String
    let logo: String
}


extension TeamAPIModel: Cenas {}
