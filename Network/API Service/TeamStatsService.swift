//
//  TeamStatsService.swift
//  F1 app
//
//  Created by Henrique Pacheco on 14/05/2025.
//

import Foundation

protocol TeamStatsServiceProtocol {
    func fetchTeam(id: String) async throws ->TeamStatsAPIModel
}

struct TeamStatsService {
    let client: APIClientFetchable
    
    init(client: APIClientFetchable) {
        self.client = client
    }
}

extension TeamStatsService :TeamStatsServiceProtocol {
    func fetchTeam(id: String) async throws -> TeamStatsAPIModel{
        let data = try await client.fetch(endpoint: TeamStatsEndpoint.team(id: id))
        return try decode(TeamStatsAPIModel.self, data: data)
    }
}

extension TeamStatsService: ModelDecodable {}

