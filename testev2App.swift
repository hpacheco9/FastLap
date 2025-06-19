//
//  testev2App.swift
//  testev2
//
//  Created by Henrique Pacheco on 27/03/2025.
//

import SwiftUI

@main
struct testev2App: App {
    

    var body: some Scene {
        WindowGroup {
          Main()
                .modelContainer(for: [StandingDataModel.self, TeamStandingsDataModel.self, Driver.self, Team.self, TeamStatsDataModel.self, ScheduleDataModel.self], isAutosaveEnabled: true)
            .preferredColorScheme(.dark)
        }
    }
}
