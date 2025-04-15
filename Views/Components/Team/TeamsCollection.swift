//
//  TeamsCollection.swift
//  testev2
//
//  Created by Henrique Pacheco on 08/04/2025.
//

import SwiftUI

struct TeamsCollection: View {
    var body: some View {
        ScrollView {
            LazyVStack {
                
                    ForEach(1..<21) { index in
                        CardTeam(Name: "Mercedes-AMG Petronas", action: {}, pos: "\(index)", points: "255", image: "https://media.api-sports.io/formula-1/teams/17.png")
                            .padding(.vertical,20)
                    }
                
            }
          
        }
    }
}


#Preview {
    TeamsCollection()
}
