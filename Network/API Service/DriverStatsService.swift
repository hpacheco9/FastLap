//
//  DriverStatsService.swift
//  F1 app
//
//  Created by Henrique Pacheco on 07/05/2025.
//

import Foundation

protocol DriverStatsServiceProtocol {
    func fetchDriver(id: String) async throws -> DriverStatsAPIModel
}

struct DriverStatsService {
    let client: APIClientFetchable
    
    init(client: APIClientFetchable) {
        self.client = client
    }
}

extension DriverStatsService: DriverStatsServiceProtocol {
    func fetchDriver(id: String) async throws -> DriverStatsAPIModel {
        let data = try await client.fetch(endpoint: DriverEndpoint.driver(id: id))
        return try decode(DriverStatsAPIModel.self, data: data)
    }
}

extension DriverStatsService: ModelDecodable {}
