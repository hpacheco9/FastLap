//
//  CardTeam.swift
//  testev2
//
//  Created by Henrique Pacheco on 08/04/2025.
//

import SwiftUI

struct CardTeam: View {
    
    var Name: String
    var action: () -> Void
    var pos: String
    var points: String
    var image: String
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        //Card
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
                Button (action: action){
                    Label("",systemImage: "chevron.right")
                }
                .foregroundColor(.primary)
                .font(.system(size: 20, weight: .bold))
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing, 10)
            .padding(.bottom, 220)
            
            // header
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(Name)
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.primary)
                    
                    }
                    .frame(width: 300)
                
                }
                .padding(.top, 10)
                .padding(.leading, 10)
                
                // Pos e Pts
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading) {
                        Text("Pos")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.gray)
                        Text(pos.addZero())
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.primary)
                    }
                    .padding(.leading, 30)
                    .padding(.bottom, 10)
                
                    VStack(alignment: .leading) {
                        Text("Pts")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.gray)
                        Text(points.addZero())
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.primary)
                    }
                    .frame(maxWidth: 330, alignment: .leading)
                    .padding(.leading, 30)
                    .padding(.bottom, 10)
                    
                    ZStack {
                        HStack {
                            ZStack {
                                AsyncImage(url: URL(string: image)) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 200, height: 220)
                                        .clipped()
                                        .padding(.bottom, 40)
                                        .padding()

                                } placeholder: {
                                    ProgressView()
                                }
                                .padding(.trailing, 60)
                            }
                            .frame(maxWidth: 150)
                           
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 220, alignment: .trailing)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 280)
        
    }
}





#Preview {
    CardTeam(Name: "Mercedes-AMG Petronas", action: {}, pos: "01", points: "55", image: "https://media.api-sports.io/formula-1/teams/14.png")
}
