//
//  ScheduleService.swift
//  F1 app
//
//  Created by Henrique Pacheco on 29/04/2025.
//

import Foundation

protocol ScheduleServiceProtocol {
    func fetchSchedule() async throws -> [ScheduleDataModel]
    func fetchScheduleDataModel() throws -> [ScheduleDataModel]
}

struct ScheduleService {
    
    let client: APIClientFetchable
    let scheduleRepository: ScheduleRepository
    
    init(client: APIClientFetchable, scheduleRepository: ScheduleRepository) {
        self.client = client
        self.scheduleRepository = scheduleRepository
    }
}


extension ScheduleService: ScheduleServiceProtocol {
    func fetchSchedule() async throws -> [ScheduleDataModel] {
        let data = try await client.fetch(endpoint: HomeEndpoint.schedule(season: "2023"))
        let decoder = try decode(ScheduleAPIModel.self, data: data)
        return try scheduleRepository.addSchedule(decoder.response, season: 2023)
    }
    
    func fetchScheduleDataModel() throws -> [ScheduleDataModel] {
        return try scheduleRepository.fetchSchedule(season: 2023)
    }
}


extension ScheduleService: ModelDecodable {}

