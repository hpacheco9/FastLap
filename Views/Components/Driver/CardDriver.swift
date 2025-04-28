//
//  ContentView.swift
//  testev2
//
//  Created by Henrique Pacheco on 26/03/2025.
//

import SwiftUI

struct CardDriver: View {
    
    let driver: DriverModel
    
  
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
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
                .padding(.bottom, 200)
                
                // header
                VStack(alignment: .leading, spacing: 0) {
                    HStack(alignment: .top) {
                        Image(driver.team.logo)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 40)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(driver.driver.name.components(separatedBy: " ")[0])
                                .foregroundStyle(.primary)
                                .font(.title2)
                            
                            Text(driver.driver.name.components(separatedBy: " ")[1])
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
                            Text("\(driver.position)".addZero())
                                .font(.system(size: 40, weight: .bold))
                                .foregroundColor(.primary)
                        }
                        .padding(.leading, 30)
                        .padding(.bottom, 10)
                        
                        VStack(alignment: .leading) {
                            Text("Pts")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.gray)
                            Text("\(driver.points ?? 0)".addZero())
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
                                    Text("\(driver.driver.number ?? 0)")
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
                                    AsyncImage(url: URL(string: driver.driver.imageUrl)) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 200, height: 200)
                                            .clipped()
                                            .padding(.trailing, 40)
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
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(10)
    }
}

#Preview {
    
    let driverModel = DriverModel(
        position: 1,
        driver: DriverModel.Driver(
            id: 1,
            name: "Max Verstappen",
            number: 33,
            abbreviation: "VER",
            imageUrl: "teste"
        ),
        team: DriverModel.Team(id: 1, name: "Red Bull Racing", logo: "Teste"),
        points: 55,
        wins: 3,
        behind: 0,
        season: 2023)
    
    CardDriver(driver: driverModel)
}
