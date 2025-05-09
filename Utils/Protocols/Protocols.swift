//
//  Protocols.swift
//  testev2
//
//  Created by Henrique Pacheco on 11/04/2025.
//

import Foundation

protocol Cenas {
    func assetForTeamId(_ teamId: Int) -> String
}

extension Cenas {
    func assetForTeamId(_ teamId: Int) -> String {
        switch teamId {
        case 1:
            return "redbull"
        case 2:
            return "mclaren"
        case 3:
            return "ferrari"
        case 5:
            return "mercedes"
        case 7:
            return "rbvisa"
        case 12:
            return "williams"
        case 13:
            return "alpine"
        case 14:
            return "haas"
        case 17:
            return "aston"
        case 18:
            return "kick"
        default:
            return ""
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
