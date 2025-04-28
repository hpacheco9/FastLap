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
        default:
            return "asset3"
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
