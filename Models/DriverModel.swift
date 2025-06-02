//
//  DriverModel.swift
//  F1 app
//
//  Created by Henrique Pacheco on 23/04/2025.
//

import Foundation
import SwiftUI

struct DriverModel {
    
    struct Driver {
        let id: Int
        let name: String
        
        let number: Int?
        let abbreviation: String?
        let imageUrl: String
    }
    
    struct Team: AssetForTeam  {
        let id: Int
        let name: String
        let logo: String
        let color: Color
    }
    
    let position: Int
    let driver: Driver
    let team: Team
    let points: Int?
    let wins: Int?
    let behind: Int?
    let season: Int

}
