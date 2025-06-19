//
//  StandingsService.swift
//  F1 app
//
//  Created by Henrique Pacheco on 29/04/2025.
//

import Foundation


protocol StandingsServiceProtocol {
    func fetchDriversRankings() async throws -> [StandingDataModel]
    func fetchTeamsRankings() async throws -> [TeamStandingsDataModel]
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
    func fetchDriversRankings() async throws -> [StandingDataModel] {
        let data = try await client.fetch(endpoint: HomeEndpoint.rankings(season: "2023"))
        let decoder = try decode(RankingsAPIModel.self, data: data)
        let model = try standingsREpository.insertDrivers(decoder.response, season: 2023)
        return model
    }
    
    func fetchTeamsRankings() async throws -> [TeamStandingsDataModel] {
        let data = try await client.fetch(endpoint: StandingsEndpoint.teams(season: "2023"))
        let decoder =  try decode(TeamRankingsAPIModel.self, data: data)
        let model = try standingsREpository.insertTeams(decoder.response, season: 2023)
        return model
    }
    
    func getStandingsData() throws -> (drivers: [StandingDataModel], teams: [TeamStandingsDataModel]) {
        return (try standingsREpository.fetchDrivers(season: 2023), try standingsREpository.fetchTeams(season: 2023))
    }
}

extension StandingsService: ModelDecodable {}
