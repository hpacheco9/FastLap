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
    var addZero: String {
         self.count == 1 ? "0" + self : self    
    }
}

