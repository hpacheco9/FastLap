//
//  RaceStandings.swift
//  F1 app
//
//  Created by Henrique Pacheco on 26/05/2025.
//

import SwiftUI

struct RaceResults: View {
    
    var standing: RaceStandingsPageViewmodel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.primary.opacity(0.1))
                .overlay(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            colorScheme == .dark ? .secondary.opacity(0.01) : .white.opacity(0.5),
                            .clear
                        ]),
                        startPoint: colorScheme == .dark ? .bottom : .top,
                        endPoint: colorScheme == .dark ? .top : .bottom
                    )
                )
            
            HStack {
                Text("\(standing.position)")
                    .padding(.leading)
                    .font(.system(size: 28, weight: .medium))
                    .frame(maxWidth: 51, alignment: .center)
                    .accessibilityLabel("Position \(standing.position)")
                    
                Capsule()
                    .fill(standing.color)
                    .frame(maxWidth: 40, maxHeight: 7)
                    .rotationEffect(.degrees(90))
                    .frame(maxWidth: 30, alignment: .leading)
                
                Text("\(standing.abbreviation)")
                    .font(.system(size: 28, weight: .semibold))
                    .accessibilityLabel(standing.name)
                
                Text(standing.time)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .frame(alignment: .trailing)
                    .font(.system(size: 24, weight: .semibold))
                    .accessibilityLabel("Time \(standing.time)")
                    
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(height: 75)
        .padding(.horizontal)
        
        
       

        
    }
}

#Preview {
    
    let model = RaceStandingsPageViewmodel(
        model:
            RaceStandings(id: 1,
                          name: "Race Name",
                          position: 1,
                          abbreviation: "VER",
                          time: "1:25:27.325", color: .cyan)
    )
    
    let model2 = RaceStandingsPageViewmodel(
        model:
            RaceStandings(id: 2,
                          name: "Race Name 2",
                          position: 20,
                          abbreviation: "BOT",
                          time: "+27.325", color: .clear)
    )
    ResultsHeader()
    RaceResults(standing: model)
    RaceResults(standing: model2)
}
