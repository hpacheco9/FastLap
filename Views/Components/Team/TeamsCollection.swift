//
//  TeamsCollection.swift
//  testev2
//
//  Created by Henrique Pacheco on 08/04/2025.
//

import SwiftUI

struct TeamsCollection: View {
    let teams: [TeamPageViewmodel]
    
    @EnvironmentObject var coordinator: Coordinator

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 12) {
                ForEach(teams, id: \.id) { team in
                    CardTeam(team: team).onTapGesture {
                        coordinator.present(sheet: .teamprofile(viewmodel:TeamStatsViewmodel(
                            dependencies:
                                    .init(
                                        service: TeamStatsService(client: APIClient(session: URLSession(configuration: .default))), team: team
                                )
                            )
                        ))
                    }
                }
            }
        }
    }
}

#Preview {
   // TeamsCollection()
}
