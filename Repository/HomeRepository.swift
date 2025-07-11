//
//  HomeRepository.swift
//  F1 app
//
//  Created by Henrique Pacheco on 04/06/2025.
//

import Foundation
import SwiftData


protocol HomeRepositoryProtocol {
    func fetchStandings(season: Int) throws -> [StandingDataModel]
    func insertStanding(_ standings: [RankingsAPIModel.Response], season: Int) throws -> [StandingDataModel]
    func insertSchedule(_ schedule: [ScheduleAPIModel.Response?]) throws -> [ScheduleDataModel]
    func fetchSchedule(season: Int) throws -> [ScheduleDataModel]
}

class HomeRepository {
    
    let standingsRepsitory: DriverStandingsRepositoryProtocol?
    let scheduleRepository: ScheduleRepository?
    
   init(standingsRepsitory: DriverStandingsRepositoryProtocol?, scheduleRepository: ScheduleRepository?) {
        self.standingsRepsitory = standingsRepsitory
        self.scheduleRepository = scheduleRepository
    }
}

extension HomeRepository: HomeRepositoryProtocol {
    func insertStanding(_ standings: [RankingsAPIModel.Response], season: Int) throws -> [StandingDataModel] {
        guard let repository = self.standingsRepsitory else {
            throw HomerRepositoryError.noStandingsRepository
        }
        return try repository.addStandings(standings, season:  season)
    }
    
    func fetchStandings(season: Int) throws -> [StandingDataModel] {
        guard let repository = self.standingsRepsitory else {
            throw HomerRepositoryError.noStandingsRepository
        }
        return try repository.fetchStandings(season: season)
    }
    
    func insertSchedule(_ schedule: [ScheduleAPIModel.Response?]) throws -> [ScheduleDataModel] {
        guard let repository = self.scheduleRepository else {
            throw HomerRepositoryError.noScheduleRepository
        }
        return try repository.addSchedule(schedule, season: 2023)
    }
    
    func fetchSchedule(season: Int) throws -> [ScheduleDataModel] {
        guard let repository = self.scheduleRepository else {
            throw HomerRepositoryError.noScheduleRepository
        }
        return try repository.fetchSchedule(season: season)
    }
}


enum HomerRepositoryError : Error {
    case noStandingsRepository
    case noScheduleRepository
}
