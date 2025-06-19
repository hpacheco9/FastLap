//
//  ScheduleRepository.swift
//  F1 app
//
//  Created by Henrique Pacheco on 02/06/2025.
//

import Foundation
import SwiftData


protocol ScheduleRepositoryProtocol {
    func fetchSchedule(season: Int) throws -> [ScheduleDataModel]
    func fetchScheduleById(season: Int, id: Int) throws -> ScheduleDataModel?
    func addSchedule(_ schedule: [ScheduleAPIModel.Response?])  throws -> [ScheduleDataModel] 
}


class ScheduleRepository {
    
    var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
}

extension ScheduleRepository {
    
    func fetchSchedule(season: Int) throws -> [ScheduleDataModel] {
        let predicate = #Predicate<ScheduleDataModel> {
           $0.season == season
        }
        let descriptor = FetchDescriptor(
            predicate: predicate,
            sortBy: [SortDescriptor(\.date)]
        )
        do {
            let fetchedSchedule = try modelContext.fetch(descriptor)
            return fetchedSchedule
        }catch {
            print(error)
            return []
        }
    }
    
    func fetchScheduleById(season: Int, id: Int) throws -> ScheduleDataModel? {
        let predicate = #Predicate<ScheduleDataModel> {
           $0.season == season && $0.id == id
        }
        let descriptor = FetchDescriptor(predicate: predicate)
        guard let fetchedSchedule = try modelContext.fetch(descriptor).first else { return nil }
        return fetchedSchedule
    }
    
    func addSchedule(_ schedule: [ScheduleAPIModel.Response?], season: Int) throws -> [ScheduleDataModel] {
        guard !schedule.isEmpty else { throw RepositoryError.emptyContent }
        
        for response in schedule {
            guard let response = response else { continue }

            if let existing = try fetchScheduleById(season: response.season, id: response.id) {
                existing.type = ScheduleTypes(rawValue: response.type.rawValue) ?? .race
                existing.status = response.status ?? .soon
                existing.date = response.date
                
                existing.competition = Competition(
                    id: response.competition.id,
                    name: response.competition.name,
                    location: .init(
                        country: response.competition.location.country,
                        city: response.competition.location.city
                    )
                )
                existing.circuit = Circuit(
                    id: response.circuit.id,
                    name: response.circuit.name,
                    image: response.circuit.assetForCircuitId(response.circuit.id)
                )
                
            } else {
                let competition = Competition(
                    id: response.competition.id,
                    name: response.competition.name,
                    location: .init(
                        country: response.competition.location.country,
                        city: response.competition.location.city
                    )
                )

                let circuit = Circuit(
                    id: response.circuit.id,
                    name: response.circuit.name,
                    image: response.circuit.assetForCircuitId(response.circuit.id)
                )

                let schedule = ScheduleDataModel(
                    id: response.id,
                    competition: competition,
                    circuit: circuit,
                    season: response.season,
                    type: ScheduleTypes(rawValue: response.type.rawValue) ?? .race,
                    date: response.date,
                    timezone: response.timezone,
                    status: response.status ?? .soon
                )

                modelContext.insert(schedule)
            }
        }

        do {
            try modelContext.save()
        } catch {
            print("Erro ao salvar: \(error)")
            throw error
        }

        return try fetchSchedule(season: season)
    }
}


