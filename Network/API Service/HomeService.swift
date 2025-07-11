//
//  APIService.swift
//  testev2
//
//  Created by Henrique Pacheco on 10/04/2025.
//

import Foundation

protocol HomeServiceProtocol {
    func fetchRankings() async throws -> RankingsAPIModel
    func fetchStandings() throws -> [StandingDataModel]
    func fetchSchedule() async throws -> ScheduleAPIModel 
    func fetchScheduleData() throws -> [ScheduleDataModel]
}

protocol HomeServiceStoreProtocol {
    func insertRankings(_ rankings: [RankingsAPIModel.Response]) throws -> [StandingDataModel]
    func insertSchedule(_ schedule: [ScheduleAPIModel.Response]) throws -> [ScheduleDataModel]
}

struct Homeservice {
    let client: APIClientFetchable
    let homeRepository: HomeRepositoryProtocol

    init(client: APIClientFetchable, homeRepository: HomeRepositoryProtocol) {
        self.client = client
        self.homeRepository = homeRepository
    }
}

extension Homeservice: HomeServiceProtocol {
    func fetchRankings() async throws -> RankingsAPIModel {
        let data = try await client.fetch(endpoint: HomeEndpoint.rankings(season: "2023"))
        let apiModel = try decode(RankingsAPIModel.self, data: data)
        return apiModel
    }
    
    func fetchStandings()  throws -> [StandingDataModel] {
        return try homeRepository.fetchStandings(season: 2023)
    }
    
    func fetchSchedule() async throws -> ScheduleAPIModel {
        let data = try await client.fetch(endpoint: HomeEndpoint.schedule(season: "2023"))
        let decoder = try decode(ScheduleAPIModel.self, data: data)
        return decoder
    }
    
    func fetchScheduleData() throws -> [ScheduleDataModel] {
        return try homeRepository.fetchSchedule(season: 2023)
    }
}

extension Homeservice: HomeServiceStoreProtocol {
    func insertRankings(_ rankings: [RankingsAPIModel.Response])  throws -> [StandingDataModel] {
       try homeRepository.insertStanding(rankings, season: 2023)
    }
    
    func insertSchedule(_ schedule: [ScheduleAPIModel.Response]) throws -> [ScheduleDataModel] {
        try homeRepository.insertSchedule(schedule)
    }
}

extension Homeservice: ModelDecodable {}
