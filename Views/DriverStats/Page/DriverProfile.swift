//
//  DriverProfile.swift
//  F1 app
//
//  Created by Henrique Pacheco on 11/04/2025.
//

import SwiftUI

struct DriverProfile: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    let viewmodel: DriverStatsViewmodel
    
    var body: some View {
        VStack {
            switch viewmodel.state {
            case .loading:
                ProgressView()

            case .loaded(let driver):
                VStack {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 0) {
                            // Header with number and image
                            HStack {
                                Text(driver.number)
                                    .font(.system(size: 90, weight: .medium))
                                    .foregroundColor(.orange.opacity(0.8))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 10)
                                
                                AsyncImage(url: URL(string: driver.image)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 200)
                                        .clipped()
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                        .padding(.bottom, 20)
                                        .mask(
                                            LinearGradient(
                                                gradient: Gradient(stops: [
                                                    .init(color: .black, location: 0),
                                                    .init(color: .black, location: 0.6),
                                                    .init(color: .clear, location: 1)
                                                ]),
                                                startPoint: .top,
                                                endPoint: .bottom
                                            )
                                        )
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                            .frame(maxWidth: .infinity)

                            // Stats card
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.primary.opacity(0.07))
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

                                VStack {
                                    // Header titles
                                    HStack {
                                        VStack(alignment: .leading, spacing: 15) {
                                            Text("F1 2025")
                                                .font(.system(size: 24, weight: .semibold))
                                            Text("Championship stats")
                                                .font(.subheadline)
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)

                                        VStack {
                                            Image(driver.teamLogo)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: 40)
                                            Text(driver.teamName)
                                                .font(.system(size: 16, weight: .semibold))
                                        }
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                    }

                                    HStack {
                                        VStack {
                                            Text("Position")
                                                .font(.system(size: 20))
                                                .foregroundStyle(.secondary)
                                            Text("\(driver.position)".addZero())
                                                .font(.system(size: 60, weight: .bold))
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)

                                        VStack {
                                            Text("Wins")
                                                .font(.system(size: 20))
                                                .foregroundStyle(.secondary)
                                            Text("11")
                                                .font(.system(size: 60, weight: .bold))
                                        }
                                        .frame(maxWidth: .infinity, alignment: .center)

                                        VStack {
                                            Text("Points")
                                                .font(.system(size: 20))
                                                .foregroundStyle(.secondary)
                                            Text("\(driver.points)".addZero())
                                                .font(.system(size: 60, weight: .bold))
                                        }
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                        .padding(.leading, 20)
                                    }
                                    .padding(.top, 20)

                                    // Career stats
                                    Text("Since Debut")
                                        .font(.system(size: 22, weight: .semibold))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.top, 5)

                                    HStack {
                                        VStack {
                                            Text("Wins")
                                                .font(.system(size: 16))
                                                .foregroundStyle(.secondary)
                                            Text("\(driver.total_wins)")
                                                .font(.system(size: 40, weight: .bold))
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)

                                        VStack {
                                            Text("Podiums")
                                                .font(.system(size: 16))
                                                .foregroundStyle(.secondary)
                                            Text("\(driver.podiums)")
                                                .font(.system(size: 40, weight: .bold))
                                        }
                                        .frame(maxWidth: .infinity, alignment: .center)

                                        VStack {
                                            Text("GPs Entered")
                                                .font(.system(size: 16))
                                                .foregroundStyle(.secondary)
                                            Text("\(driver.gpEntries)")
                                                .font(.system(size: 40, weight: .bold))
                                        }
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                    }
                                    .padding(.top, 5)

                                    // World championships
                                    VStack(alignment: .leading) {
                                        Text("World Championships")
                                            .font(.system(size: 25, weight: .semibold))
                                            .padding(.top, 10)

                                        Text(String(driver.worldChampionships))
                                            .font(.system(size: 60, weight: .bold))
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .frame(maxHeight: .infinity, alignment: .top)
                                .padding()
                            }
                            .frame(maxHeight: .infinity, alignment: .top)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.horizontal, 10)
                    }
                }
                .navigationTitle(driver.name)
                .navigationBarTitleDisplayMode(.large)
                

            case .error:
                Text("Error")

            case .empty:
                EmptyView()
            }

            
        }
        .task {
            await viewmodel.loadData()
        }
    }
}

#Preview {
    
DriverProfile(viewmodel : DriverStatsViewmodel(
        dependencies:
                .init(
                    service: DriverStatsService(client: APIClient(session: URLSession(configuration: .default))), driver: DriverModel(
                        position: 1,
                        driver: DriverModel.Driver(
                            id: 25,
                            name: "Max Verstappen",
                            number: 33,
                            abbreviation: "VER",
                            imageUrl: "https://media.api-sports.io/formula-1/drivers/49.png"
                        ),
                        team: DriverModel.Team(id: 1, name: "Red Bull Racing", logo: "redbull"),
                        points: 55,
                        wins: 3,
                        behind: 0,
                        season: 2023)
            )
        )
    )
    /*DriverProfile(client: DriverStatsService(client:APIClient(session: URLSession(configuration: .default))))
      .padding()*/
}
