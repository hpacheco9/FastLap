//
//  RaceRankingsService.swift
//  F1 app
//
//  Created by Henrique Pacheco on 26/05/2025.
//

import Foundation

protocol RaceRankingsServiceProtocol {
    func fetchRaceRankings(race: String) async throws -> RaceRankingsAPIModel
}


struct RaceRankingsService {
    let client: APIClientFetchable
    
    init(client: APIClientFetchable) {
        self.client = client
    }
}

extension RaceRankingsService: RaceRankingsServiceProtocol {
    func fetchRaceRankings(race: String) async throws -> RaceRankingsAPIModel {
        let data = try await client.fetch(endpoint: RaceStandingsEndpoint.race(race: race))
        return try decode(RaceRankingsAPIModel.self, data: data)
    }
}   

extension RaceRankingsService: ModelDecodable {}
