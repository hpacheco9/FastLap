//
//  CapsuleTypes.swift
//  testev2
//
//  Created by Henrique Pacheco on 10/04/2025.
//

import SwiftUI
import Foundation

enum Status: String, CaseIterable {
    case live
    case soon
    var text: String {
        switch self {
        case .live:
            return "Watch live"
        case .soon:
            return "Soon"
        }
    }
    
    var color: Color {
        switch self {
            case .live:
                return .orange
            case .soon:
                return .secondary
        }
    }
    
}
