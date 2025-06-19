//
//  StandingsRepository.swift
//  F1 app
//
//  Created by Henrique Pacheco on 06/06/2025.
//

import Foundation


protocol StandingsRepositoryProtocol {
    func fetchDrivers(season: Int) throws -> [StandingDataModel]
    func fetchTeams(season: Int) throws -> [TeamStandingsDataModel]
    func insertDrivers(_ drivers: [RankingsAPIModel.Response], season: Int) throws -> [StandingDataModel]
    func insertTeams(_ teams: [TeamRankingsAPIModel.Response], season: Int) throws -> [TeamStandingsDataModel]
}

class StandingsRepository {
    var driverRepository: DriverStandingsRepositoryProtocol
    var teamStandings: TeamStandingsRepositoryProtocol
    
    
    init(driverRepository: DriverStandingsRepository, teamStandings: TeamStandingsRepository) {
        self.driverRepository = driverRepository
        self.teamStandings = teamStandings
    }
}

extension StandingsRepository: StandingsRepositoryProtocol {
    func fetchDrivers(season: Int) throws -> [StandingDataModel]{
        return try driverRepository.fetchAllStandings()
    }
    
    func fetchTeams(season: Int) throws -> [TeamStandingsDataModel]{
        return try teamStandings.fetchStandingsTeams(season: season)
    }
    
    func insertDrivers(_ drivers: [RankingsAPIModel.Response], season: Int) throws -> [StandingDataModel] {
        return try driverRepository.addStandings(drivers, season: season)
    }
    
    func insertTeams(_ teams: [TeamRankingsAPIModel.Response], season: Int) throws -> [TeamStandingsDataModel] {
        return try teamStandings.insertTeams(teamStandings: teams, season: season)
    }
}
