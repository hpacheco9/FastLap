//
//  ContentView.swift
//  testev2
//
//  Created by Henrique Pacheco on 26/03/2025.
//

import SwiftUI

struct CardDriver: View {
    let number: String
    let action: () -> Void
    let first: String
    let last: String
    let image: String
    let equipa: String
    
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
            .padding(.bottom, 200)
            
            // header
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .top) {
                    Image(equipa)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(first)
                            .foregroundStyle(.primary)
                            .font(.title2)
                        
                        Text(last)
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.orange)
                    }
                }
                .padding(.leading, 10)
                .padding(.top, 20)
                
                // Pos e Pts
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading) {
                        Text("Pos")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.gray)
                        Text("01")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.primary)
                    }
                    .padding(.leading, 30)
                    .padding(.bottom, 10)
                
                    VStack(alignment: .leading) {
                        Text("Pts")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.gray)
                        Text("255")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.primary)
                    }
                    .frame(maxWidth: 330, alignment: .leading)
                    .padding(.leading, 30)
                    .padding(.bottom, 10)
                    
                    // Driver Number
                    ZStack {
                        HStack {
                            ZStack {
                                Text(number)
                                    .font(.system(size: 120, weight: .medium))
                                    .foregroundStyle(
                                        LinearGradient(
                                            colors: [.orange, .orange.opacity(0.1)],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .offset(x: -70)
                                
                                // image of driver
                                AsyncImage(url: URL(string: "https://media.api-sports.io/formula-1/drivers/49.png")) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 200, height: 200)
                                        .clipped()
                                        .padding(.trailing, 30)
                                        .padding(.bottom, 20)
                                } placeholder: {
                                    ProgressView()
                                }

                            }
                            .frame(maxWidth: 150)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 180, alignment: .trailing)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 250)
        .padding(3)
    }
}

#Preview {
    CardDriver(number: "44", action: {}, first: "Charles", last: "Piastri", image: "ham", equipa: "mclaren")
}
