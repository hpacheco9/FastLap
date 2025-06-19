//
//  APIService.swift
//  testev2
//
//  Created by Henrique Pacheco on 10/04/2025.
//

import Foundation

protocol HomeServiceProtocol {
    func fetchRankings() async throws -> [StandingDataModel]
    func fetchStandings() throws -> [StandingDataModel]
    func fetchSchedule() async throws -> [ScheduleDataModel]
    func fetchScheduleData() throws -> [ScheduleDataModel]
}

struct Homeservice {
    let client: APIClientFetchable
    let homeRepository: HomeRepositoryProtocol

    init(client: APIClientFetchable, homeRepository: HomeRepositoryProtocol) {
        self.client = client
        self.homeRepository = homeRepository
    }
}

extension Homeservice: HomeServiceProtocol{
    func fetchRankings() async throws -> [StandingDataModel] {
        let data = try await client.fetch(endpoint: HomeEndpoint.rankings(season: "2023"))
        let decoder = try decode(RankingsAPIModel.self, data: data)
        let model = try homeRepository.insertStanding(decoder.response, season: 2023)
        return model
    }
    
    func fetchStandings()  throws -> [StandingDataModel] {
        return try homeRepository.fetchStandings(season: 2023)
    }
    
    func fetchSchedule() async throws -> [ScheduleDataModel] {
        let data = try await client.fetch(endpoint: HomeEndpoint.schedule(season: "2023"))
        let decoder = try decode(ScheduleAPIModel.self, data: data)
        return try homeRepository.insertSchedule(decoder.response)
    }
    
    func fetchScheduleData() throws -> [ScheduleDataModel] {
        return try homeRepository.fetchSchedule(season: 2023)
    }
}

extension Homeservice: ModelDecodable {}
