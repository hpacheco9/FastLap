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
        case 4:
            return "ChinaGP"
        default:
            return "asset3"
        }
    }
}
