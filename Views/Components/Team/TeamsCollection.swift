//
//  TeamsCollection.swift
//  testev2
//
//  Created by Henrique Pacheco on 08/04/2025.
//

import SwiftUI

struct TeamsCollection: View {
    let teams: [TeamModel]

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 12) {
                ForEach(teams, id: \.id) { team in
                    CardTeam(team: team)
                        
                }
            }
        }
    }
}

#Preview {
   // TeamsCollection()
}
