//
//  Coordinator.swift
//  testev2
//
//  Created by Henrique Pacheco on 08/04/2025.
//

import SwiftUI

enum Page: String, Identifiable {
    case home, standings, shcedule

    var id : String {
        self.rawValue
    }
}

enum Sheet: String, Identifiable {
    case driverprofile
    
    var id : String {
        self.rawValue
    }
}


enum Fullcover: String, Identifiable {
    case driver
    
    var id : String {
        self.rawValue
    }
}

class Coordinator: ObservableObject {
    
    @Published var path = NavigationPath()
    @Published var sheet: Sheet?
    @Published var fullcover: Fullcover?
    
    
    
    func push(page: Page) {
        path.append(page)
    }
    
    func presentSheet(sheet: Sheet) {
        self.sheet = sheet
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    func presentFullcover(fullcover: Fullcover) {
        self.fullcover = fullcover
    }
    
    func dismissFullcover() {
        self.fullcover = nil
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    @ViewBuilder
    func build(page: Page) -> some View {
        switch page {
        case .home:
            Home()
        case .standings:
            Standings()
        case .shcedule:
            Schedule()
        }
    }
    

    @ViewBuilder
    func build(sheet: Sheet) -> some View {
        switch sheet {
        case .driverprofile:
            DriverProfile()
        }
    }
    
    
}
