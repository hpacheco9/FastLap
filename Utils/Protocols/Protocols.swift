//
//  Protocols.swift
//  testev2
//
//  Created by Henrique Pacheco on 11/04/2025.
//

import Foundation
import SwiftUI

protocol AssetForTeam  {
    func assetForTeamId(_ teamId: Int) -> (String, Color)
}

extension AssetForTeam {
    func assetForTeamId(_ teamId: Int) -> (String, Color){
        switch teamId {
        case 1:
            return ("redbull", .red)
        case 2:
            return ("mclaren", .orange)
        case 3:
            return ("ferrari", .red)
        case 5:
            return ("mercedes", .mint)
        case 7:
            return ("rbvisa", .blue)
        case 12:
            return ("williams", .blue)
        case 13:
            return ("alpine", .cyan)
        case 14:
            return ("haas", .red)
        case 17:
            return ("aston", .teal)
        case 18:
            return ("kick", .green)
        default:
            return ("", .clear)
        }
    }
}

protocol CircuitAsset {
    func assetForCircuitId(_ circuitId: Int) -> String
}

extension CircuitAsset {
    func assetForCircuitId(_ circuitId: Int) -> String {
        switch circuitId{
        case 1:
            return "australiaGP"
        case 2:
            return "bahrainGP"
        case 4:
            return "ChinaGP"
        case 5:
            return "zandvoort"
        case 6:
            return "barca"
        case 7:
            return "monacoGP"
        case 8:
            return "bakuGP"
        case 9:
            return "canadaGP"
        case 11:
            return "austriaGP"
        case 12:
            return "silverstone"
        case 14:
            return "hungaryGP"
        case 15:
            return "spa"
        case 16:
            return "monza"
        case 17:
            return "singaporeGP"
        case 19:
            return "japanGP"
        case 20:
            return "americasGP"
        case 21:
            return "mexicoGP"
        case 22:
            return "interlagos"
        case 23:
            return "abudabi"
        case 27:
            return "emiliaGP"
        case 29:
            return "saudiGP"
        case 30:
            return "quatarGP"
        case 31:
            return "miamiGP"
        case 32:
            return "lasvegasGP"
        default:
            return "asset3"
        }
    }
}
