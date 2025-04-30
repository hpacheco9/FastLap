//
//  APIService.swift
//  testev2
//
//  Created by Henrique Pacheco on 10/04/2025.
//

import Foundation

protocol HomeServiceProtocol {
    func fetchRankings() async throws -> RankingsAPIModel
    func fetchSchedule() async throws -> ScheduleAPIModel
}

struct Homeservice {
    let client: APIClientFetchable

    init(client: APIClientFetchable) {
        self.client = client
    }
}

extension Homeservice: HomeServiceProtocol{
    func fetchRankings() async throws -> RankingsAPIModel {
        let data = try await client.fetch(endpoint: HomeEndpoint.rankings(season: "2023"))
        return try decode(RankingsAPIModel.self, data: data)
    }
    
    func fetchSchedule() async throws -> ScheduleAPIModel {
        let data = try await client.fetch(endpoint: HomeEndpoint.schedule(season: "2023"))
        return try decode(ScheduleAPIModel.self, data: data)
    }
}

extension Homeservice: ModelDecodable {}










