//
//  TeamStatsView.swift
//  F1 app
//
//  Created by Henrique Pacheco on 15/05/2025.
//

import SwiftUI

struct TeamStatsView: View {
    @Environment(\.colorScheme) var colorScheme
    var viewmodel: TeamStatsViewmodel

    var body: some View {
        VStack {
            switch viewmodel.state {
            case .loading:
                ProgressView()
            case .loaded(let team):
                VStack {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 0) {
                            Image(team.logo)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 180)
                                .clipped()
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.bottom, 5)
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
                        }
                        
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
                                HStack {
                                    VStack(alignment: .leading, spacing: 15) {
                                        Text("F1 2025")
                                            .font(.system(size: 24, weight: .semibold))
                                        Text("Championship stats")
                                            .font(.subheadline)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                }

                                HStack {
                                    VStack {
                                        Text("Position")
                                            .font(.system(size: 20))
                                            .foregroundStyle(.secondary)
                                        Text("\(team.position)".addZero)
                                            .font(.system(size: 46, weight: .bold))
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                    VStack {
                                        Text("Wins")
                                            .font(.system(size: 20))
                                            .foregroundStyle(.secondary)
                                        Text(team.wins.addZero)
                                            .font(.system(size: 46, weight: .bold))
                                    }
                                    .frame(maxWidth: .infinity, alignment: .center)

                                    VStack(alignment: .leading ) {
                                        Text("Points")
                                            .font(.system(size: 20))
                                            .foregroundStyle(.secondary)
                                        Text("\(team.points)".addZero)
                                            .font(.system(size: 46  , weight: .bold))
                                    }
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .padding(.leading, 20)
                                }
                                .padding(.top, 20)

                                Text("Since Debut")
                                    .font(.system(size: 22, weight: .semibold))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.top, 5)

                                HStack {
                                    VStack {
                                        Text("Wins")
                                            .font(.system(size: 16))
                                            .foregroundStyle(.secondary)
                                        Text(team.wins.addZero)
                                            .font(.system(size: 40, weight: .bold))
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                    VStack {
                                        Text("Poles")
                                            .font(.system(size: 16))
                                            .foregroundStyle(.secondary)
                                        Text(team.poles.addZero)
                                            .font(.system(size: 40, weight: .bold))
                                    }
                                    .frame(maxWidth: .infinity, alignment: .center)

                                    VStack {
                                        Text("Fastest Laps")
                                            .font(.system(size: 16))
                                            .foregroundStyle(.secondary)
                                        Text(team.fastestLaps.addZero)
                                            .font(.system(size: 40, weight: .bold))
                                    }
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                }
                                .padding(.top, 5)

                                VStack(alignment: .leading) {
                                    Text("World Championships")
                                        .font(.system(size: 25, weight: .semibold))
                                        .padding(.top, 10)

                                    Text(team.championships)
                                        .font(.system(size: 60, weight: .bold))
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .frame(maxHeight: .infinity, alignment: .top)
                            .padding()
                        }
                        .frame(maxHeight: .infinity, alignment: .top)
                    }
                    .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal, 10)
                .navigationTitle(team.name)
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
    TeamStatsView(viewmodel: TeamStatsViewmodel(
        dependencies: .init(
            service: TeamStatsService(
                client: APIClient(session: URLSession(configuration: .default))),
            team: nil)))
}
