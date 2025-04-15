//
//  ChosenView.swift
//  testev2
//
//  Created by Henrique Pacheco on 10/04/2025.
//

import SwiftUI

struct StandingsView: View {
    
    var standingsType: StandingTypes
    
    var body: some View {
        
            switch standingsType {
            case .drivers:
                DriversColletion()
            case .teams:
                TeamsCollection()
            }
    }
}

enum StandingTypes: String, CaseIterable {
    case drivers = "Drivers"
    case teams = "Teams"
}



#Preview {
   StandingsView(standingsType: .drivers )
}
