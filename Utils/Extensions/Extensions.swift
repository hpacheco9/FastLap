//
//  Extensions.swift
//  F1 app
//
//  Created by Henrique Pacheco on 11/04/2025.
//

import SwiftUI
import Foundation


extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}


extension Int {
    func montNameMonth() -> String {
        guard (1...12).contains(self) else {
            return ""
        }
        return DateFormatter().monthSymbols[self - 1]
    }
}


extension String {
    func addZero() -> String {
        if self.count == 1 {
            return "0" + self
        }
        return self
    }
}


extension String {
    func getType() -> String {
        switch self {
        case "1st Qualifying":
            return "Q1"
        case "2nd Qualifying":
            return "Q2"
        case "3rd Qualifying":
            return "Q3"
        case "Race":
            return "Race"
        case "1st Practice":
            return "FP1"
        case "2nd Practice":
            return "FP2"
        case "3rd Practice":
            return "FP3"
        default :
            return ""
        }
    }
}
