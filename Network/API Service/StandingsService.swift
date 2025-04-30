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

struct StandingsService {
    let client: APIClientFetchable

    init(client: APIClientFetchable) {
        self.client = client
    }
}

extension StandingsService: StandingsServiceProtocol {
    func fetchDriversRankings() async throws -> RankingsAPIModel {
        let data = try await client.fetch(endpoint: StandingsEndpoint.drivers(season: "2023"))
        return try decode(RankingsAPIModel.self, data: data)
    }
    
    func fetchTeamsRankings() async throws -> TeamRankingsAPIModel {
        let data = try await client.fetch(endpoint: StandingsEndpoint.teams(season: "2023"))
        return try decode(TeamRankingsAPIModel.self, data: data)
    }
}

extension StandingsService: ModelDecodable {}
