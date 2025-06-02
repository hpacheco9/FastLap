//
//  LocalizationKey.swift
//  F1 app
//
//  Created by Henrique Pacheco on 29/05/2025.
//

import Foundation

enum LocalizationKey  {
    enum Header: String {
        case standings = "header.standings"
        case upcoming = "header.upcoming"
        
        var localized: String {
            String(localized: String.LocalizationValue(rawValue))
        }
    }
    
    enum TabBar: String {
        case standings = "tab.bar.standings"
        case schedule = "tab.bar.schedule"
        case home = "tab.bar.home"
        
        var localized: String {
            String(localized: String.LocalizationValue(rawValue))
        }
    }
    
    enum Button: String {
        case seeall = "button.seeall"
        
        var localized: String {
            String(localized: String.LocalizationValue(rawValue))
        }
    }
    
    enum Title: String {
        case home = "title.home"
        case standings = "title.standings"
        case schedule = "title.schedule"
        case driverDetails = "title.driverDetails"
        case teamDetails = "title.teamDetails"
        
        var localized: String {
            String(localized: String.LocalizationValue(rawValue))
        }
    }
    
    enum accessbilty: String {
        case pos = "accessbilty.pos"
        
        var localized: String {
            String(localized: String.LocalizationValue(rawValue))
        }
    }
}
