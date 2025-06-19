//
//  CardTeam.swift
//  testev2
//
//  Created by Henrique Pacheco on 08/04/2025.
//

import SwiftUI

struct CardTeam: View {
    
    let team: TeamPageViewmodel
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 20)
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
            
            VStack(alignment: .trailing) {
                Label("",systemImage: "chevron.right")
                .foregroundColor(.primary)
                .font(.system(size: 20, weight: .bold))
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing, 10)
            .padding(.top, 20)
            .padding(.bottom, 200)
            
            VStack(alignment: .leading) {
                Text(team.name)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.primary)
                    .lineLimit(1)
                    .frame(maxWidth: 300, alignment: .leading)
            }
            .frame(maxHeight: .infinity, alignment: .topLeading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 10)
            .padding(.leading, 20)
                
                // Pos e Pts
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading) {
                        Text("Pos")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.gray)
                            .accessibilityHidden(true)
                        Text("\(team.position)".addZero)
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.primary)
                            .accessibilityLabel("Position \(team.position)")
                    }
                    .padding(.leading, 30)
                    .padding(.bottom, 10)
                
                    VStack(alignment: .leading) {
                        Text("Pts")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.gray)
                            .accessibilityHidden(true)
                        Text("\(team.points)".addZero)
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.primary)
                            .accessibilityLabel(" \(team.points) Points ")
                    }
                    .frame(maxWidth: 330, alignment: .leading)
                    .padding(.leading, 30)
                    .padding(.bottom, 10)
                    
                    ZStack {
                        HStack {
                            ZStack {
                                Image(team.logo)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 130, height: 100)
                                        .clipped()
                            }
                            
                            .padding(.trailing, 30)
                            .accessibilityHidden(true)
                           
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 220, alignment: .trailing)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(10)
    }
}

#Preview {
    
    let team = TeamPageViewmodel(model: TeamModel(id: 1, position: 1, points: 100, name: "Red Bull Racing", logo: "redbull", color: .red))
    CardTeam(team: team)
        .frame(height: 280)
}
