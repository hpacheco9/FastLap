//
//  HomeRepository.swift
//  F1 app
//
//  Created by Henrique Pacheco on 29/05/2025.
//

import Foundation
import SwiftData

@Observable
class StandingsRepository {
    var modelContext: ModelContext
    var standings = [StandingDataModel]()
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func addStandings(_ newStandings: [RankingsAPIModel.Response]) async throws {
        for standingsResponse in newStandings {
            let driver = Driver(
                id: standingsResponse.driver.id,
                name: standingsResponse.driver.name,
                number: standingsResponse.driver.number,
                imageUrl: standingsResponse.driver.imageUrl
            )

            let team = Team(
                id: standingsResponse.team.id,
                name: standingsResponse.team.name,
                logo: standingsResponse.team.assetForTeamId(standingsResponse.team.id).0,
                color: standingsResponse.team.assetForTeamId(standingsResponse.team.id).1
            )

            let standings = StandingDataModel(
                position: standingsResponse.position,
                driver: driver,
                team: team,
                wins: standingsResponse.wins,
                season: standingsResponse.season
            )

            modelContext.insert(driver)
            modelContext.insert(team)
            modelContext.insert(standings)

        }
    }
    
    func fetchStandings() -> [StandingDataModel]{
        do {
            let descriptor = FetchDescriptor<StandingDataModel>(sortBy: [SortDescriptor(\.position)])
            standings = try modelContext.fetch(descriptor)
            return standings
        }
        catch {
            return []
        }
    }
}
