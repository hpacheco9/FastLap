//
//  StandingsService.swift
//  F1 app
//
//  Created by Henrique Pacheco on 29/04/2025.
//

import Foundation


protocol StandingsServiceProtocol {
    func fetchDriversRankings() async throws -> RankingsAPIModel
    func fetchTeamsRankings() async throws -> TeamRankingsAPIModel
}

protocol StandingsServiceStoreProtocol {
    func insertDriversRankings(_ rankings: [RankingsAPIModel.Response]) throws -> [StandingDataModel]
    func insertTeamsRankings(_ rankings: [TeamRankingsAPIModel.Response]) throws -> [TeamStandingsDataModel]
    func getStandingsData() throws -> (drivers: [StandingDataModel], teams: [TeamStandingsDataModel])
}

struct StandingsService {
    let client: APIClientFetchable
    let standingsREpository: StandingsRepositoryProtocol
    init(client: APIClientFetchable, standingsREpository: StandingsRepositoryProtocol) {
        self.client = client
        self.standingsREpository = standingsREpository
    }
}

extension StandingsService: StandingsServiceProtocol {
    func fetchDriversRankings() async throws -> RankingsAPIModel {
        let data = try await client.fetch(endpoint: HomeEndpoint.rankings(season: "2023"))
        let decoder = try decode(RankingsAPIModel.self, data: data)
        return decoder
    }
    
    func fetchTeamsRankings() async throws -> TeamRankingsAPIModel {
        let data = try await client.fetch(endpoint: StandingsEndpoint.teams(season: "2023"))
        let decoder =  try decode(TeamRankingsAPIModel.self, data: data)
        return decoder
    }
}

extension StandingsService: StandingsServiceStoreProtocol {
 
    func insertDriversRankings(_ rankings: [RankingsAPIModel.Response]) throws -> [StandingDataModel]{
        try standingsREpository.insertDrivers(rankings, season: 2023)
    }
    func insertTeamsRankings(_ rankings: [TeamRankingsAPIModel.Response]) throws -> [TeamStandingsDataModel]{
        try standingsREpository.insertTeams(rankings, season: 2023)
    }
  
    func getStandingsData() throws -> (drivers: [StandingDataModel], teams: [TeamStandingsDataModel]) {
        return (try standingsREpository.fetchDrivers(season: 2023), try standingsREpository.fetchTeams(season: 2023))
    }
}

extension StandingsService: ModelDecodable {}
