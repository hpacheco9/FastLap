//
//  HomeRepository.swift
//  F1 app
//
//  Created by Henrique Pacheco on 29/05/2025.
//

import Foundation
import SwiftData


protocol DriverStandingsRepositoryProtocol {
    func addStandings(_ newStandings: [RankingsAPIModel.Response], season: Int) throws -> [StandingDataModel]
    func fetchStandings(season: Int) throws -> [StandingDataModel]
    func fetchAllStandings() throws -> [StandingDataModel]
}


class DriverStandingsRepository {
    var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
}

extension DriverStandingsRepository: DriverStandingsRepositoryProtocol {
    
    func fetchStandings(season: Int) -> [StandingDataModel] {
        let predicate = #Predicate<StandingDataModel> { $0.season == season }
        let descriptor = FetchDescriptor<StandingDataModel>(
            predicate: predicate,
            sortBy: [SortDescriptor(\.position)]
        )
        
        do {
            let fetchedStandings = try modelContext.fetch(descriptor)
            return fetchedStandings
        } catch {
            return []
        }
    }

    func fetchAllStandings() -> [StandingDataModel] {
        let descriptor = FetchDescriptor<StandingDataModel>(
            sortBy: [SortDescriptor(\.position)]
        )
        
        do {
            let fetchedStandings = try modelContext.fetch(descriptor)
            return fetchedStandings
        } catch {
            return []
        }
    }

    func fetchStanding(id: Int, season: Int) throws -> StandingDataModel? {
        let predicate = #Predicate<StandingDataModel> {
            $0.driver.id == id && $0.season == season
        }
        let descriptor = FetchDescriptor(predicate: predicate)
        return try modelContext.fetch(descriptor).first
    }

    func getOrCreateTeam(response: RankingsAPIModel.Response) -> Team {
        let teamId = response.team.id
        let teamFetch = #Predicate<Team> { $0.id == teamId }
        let fetchedTeam = try? modelContext.fetch(FetchDescriptor<Team>(predicate: teamFetch)).first
        
        let logo = response.team.assetForTeamId(teamId).0
        
        if let existingTeam = fetchedTeam {
            existingTeam.logo = logo
            return existingTeam
        } else {
            let newTeam = Team(
                id: teamId,
                name: response.team.name,
                logo: logo
            )
            modelContext.insert(newTeam)
            return newTeam
        }
    }

    func getOrCreateDriver(response: RankingsAPIModel.Response) -> Driver {
        let driverId = response.driver.id
        let driverFetch = #Predicate<Driver> { $0.id == driverId }
        let fetchedDriver = try? modelContext.fetch(FetchDescriptor<Driver>(predicate: driverFetch)).first
        
        if let existingDriver = fetchedDriver {
            existingDriver.number = response.driver.number
            existingDriver.imageUrl = response.driver.imageUrl
            return existingDriver
        } else {
            let newDriver = Driver(
                id: driverId,
                name: response.driver.name,
                abbreviation: response.driver.abbreviation,
                number: response.driver.number,
                imageUrl: response.driver.imageUrl
            )
            modelContext.insert(newDriver)
            return newDriver
        }
    }

    func addStandings(_ newStandings: [RankingsAPIModel.Response], season: Int) throws -> [StandingDataModel] {
        guard !newStandings.isEmpty else { throw RepositoryError.emptyContent }

        for response in newStandings {
            let existingStanding = try fetchStanding(id: response.driver.id, season: season)
            
            let driver = getOrCreateDriver(response: response)
            let team = getOrCreateTeam(response: response)
            
            if let standing = existingStanding {
                standing.position = response.position
                standing.driver = driver
                standing.team = team
                standing.points = response.points
                standing.wins = response.wins
                standing.behind = response.behind
                standing.season = season
            } else {
                let standing = StandingDataModel(
                    position: response.position,
                    driver: driver,
                    team: team,
                    points: response.points,
                    wins: response.wins,
                    behind: response.behind,
                    season: season
                )
                modelContext.insert(standing)
            }
        }

        do {
            try modelContext.save()
        } catch {
            print("Erro ao salvar: \(error)")
        }

        return fetchStandings(season: season)
    }
}
