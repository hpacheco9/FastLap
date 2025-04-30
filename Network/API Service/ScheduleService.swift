//
//  ScheduleService.swift
//  F1 app
//
//  Created by Henrique Pacheco on 29/04/2025.
//

import Foundation


protocol ScheduleServiceProtocol {
    func fetchSchedule() async throws -> ScheduleAPIModel
}



struct ScheduleService {
    
    let client: APIClientFetchable
    
    init(client: APIClientFetchable) {
        self.client = client
    }

}


extension ScheduleService: ScheduleServiceProtocol {
    func fetchSchedule() async throws -> ScheduleAPIModel {
        let data = try await client.fetch(endpoint: HomeEndpoint.schedule(season: "2023"))
        return try decode(ScheduleAPIModel.self, data: data)
    }
}


extension ScheduleService: ModelDecodable {}

