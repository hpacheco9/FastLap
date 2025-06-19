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
    
    let standingsRepsitory: DriverStandingsRepositoryProtocol
    let scheduleRepository: ScheduleRepository
    
   init(standingsRepsitory: DriverStandingsRepositoryProtocol, scheduleRepository: ScheduleRepository) {
        self.standingsRepsitory = standingsRepsitory
        self.scheduleRepository = scheduleRepository
    }
}

extension HomeRepository: HomeRepositoryProtocol {
    func insertStanding(_ standings: [RankingsAPIModel.Response], season: Int) throws -> [StandingDataModel] {
        return try standingsRepsitory.addStandings(standings, season:  season)
    }
    
    func fetchStandings(season: Int) throws -> [StandingDataModel] {
        return try standingsRepsitory.fetchStandings(season: season)
    }
    
    func insertSchedule(_ schedule: [ScheduleAPIModel.Response?]) throws -> [ScheduleDataModel] {
        return try scheduleRepository.addSchedule(schedule, season: 2023)
    }
    
    func fetchSchedule(season: Int) throws -> [ScheduleDataModel] {
        return try scheduleRepository.fetchSchedule(season: season)
    }
}
