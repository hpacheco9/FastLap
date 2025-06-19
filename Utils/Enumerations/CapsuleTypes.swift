//
//  CapsuleTypes.swift
//  testev2
//
//  Created by Henrique Pacheco on 10/04/2025.
//

import SwiftUI
import Foundation

enum Status: String,  Codable {
    case live = "Live"
    case soon = "Schedule"
    case completed = "Completed"
    case cancelled = "Cancelled"
    case postponed = "Postponed"
    
    var text: String {
        switch self {
        case .live:
            return "Watch live"
        case .soon:
            return "Soon"
        case .completed:
            return "Completed"
        case .cancelled:
            return "Cancelled"
        case .postponed:
            return "Postponed"
        }
    }
    
    var color: Color {
        switch self {
            case .live:
                return .orange
            default:
                return .secondary
        }
    }
}
