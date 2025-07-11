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

protocol ScheduleServiceStoreProtocol {
    func fetchScheduleDataModel() throws -> [ScheduleDataModel]
    func insertSchedule(schedule: [ScheduleAPIModel.Response], season: Int) throws -> [ScheduleDataModel]
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
    func fetchSchedule() async throws -> ScheduleAPIModel {
        let data = try await client.fetch(endpoint: HomeEndpoint.schedule(season: "2023"))
        let decoder = try decode(ScheduleAPIModel.self, data: data)
        return decoder
    }
    
    
}


extension ScheduleService: ScheduleServiceStoreProtocol {
    func insertSchedule(schedule: [ScheduleAPIModel.Response], season: Int) throws -> [ScheduleDataModel] {
        let model = try scheduleRepository.addSchedule(schedule, season: season)
        return model
    }
    
    func fetchScheduleDataModel() throws -> [ScheduleDataModel] {
        return try scheduleRepository.fetchSchedule(season: 2023)
    }
}




extension ScheduleService: ModelDecodable {}

