//
//  ScheduleViewModel.swift
//  F1 app
//
//  Created by Henrique Pacheco on 02/05/2025.
//

import Foundation


@Observable
class ScheduleViewModel {
    enum State {
        case loading
        case loaded([SchedulePageViewmodel], [SchedulePageViewmodel])
        case empty
        case error
    }
    
    enum ScheduleTypes: String, CaseIterable {
        case upcoming = "Upcoming"
        case past = "Past"
    }
    
    struct Dependencies {
        let service: ScheduleServiceProtocol & ScheduleServiceStoreProtocol
    }
    
    let title = LocalizationKey.Title.schedule.localized
    
    private let dependencies: Dependencies
    var state: State = .loading
    
    init (dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    
    @MainActor
    func loadData() async {
        do {
            
            let data = try await dependencies.service.fetchSchedule()
            
            guard !data.response.isEmpty else {
                state = .empty
                return
            }
            
            let responses = data.response.compactMap({ $0 })
            
            let isoFormatter: ISO8601DateFormatter = {
                let f = ISO8601DateFormatter()
                f.formatOptions = [.withInternetDateTime]
                return f
            }()

            let now = Date()
            
           let modelResponses = try dependencies.service.insertSchedule(schedule: responses, season: 2023)

            var lastPastRaceByCircuit   = [Int: ScheduleDataModel]()
            var nextFutureRaceByCircuit = [Int: ScheduleDataModel]()

            for race in modelResponses {
                guard
                    let ds = race.date,
                    let date  = isoFormatter.date(from: ds)
                else {
                    continue
                }

                let circuitId = race.circuit.id

                if date <= now.addingTimeInterval(-3600) {
                    if let existing = lastPastRaceByCircuit[circuitId],
                       let es = existing.date,
                       let raceDate = isoFormatter.date(from: es),
                       raceDate > date {
                        
                    } else {
                        lastPastRaceByCircuit[circuitId] = race
                    }
                } else {
                    
                    if let existing = nextFutureRaceByCircuit[circuitId],
                       let es = existing.date,
                       let ed = isoFormatter.date(from: es),
                       ed < date {
                    } else {
                        nextFutureRaceByCircuit[circuitId] = race
                    }
                }
            }
            
            let pastRaces =  makeSchedule(schedule: lastPastRaceByCircuit, isofortematter: isoFormatter)
            let upcomingRaces = makeSchedule(schedule: nextFutureRaceByCircuit, isofortematter: isoFormatter)
            
            state = .loaded(pastRaces, upcomingRaces)
        }
        catch {
            do {
                
                let data = try dependencies.service.fetchScheduleDataModel()
                
                let responses = data.compactMap({ $0 })
                
                let isoFormatter: ISO8601DateFormatter = {
                    let f = ISO8601DateFormatter()
                    f.formatOptions = [.withInternetDateTime]
                    return f
                }()

                let now = Date()

                var lastPastRaceByCircuit   = [Int: ScheduleDataModel]()
                var nextFutureRaceByCircuit = [Int: ScheduleDataModel]()

                for race in responses {
                    guard
                        let ds = race.date,
                        let date  = isoFormatter.date(from: ds)
                    else {
                        continue
                    }

                    let circuitId = race.circuit.id

                    if date <= now {
                        if let existing = lastPastRaceByCircuit[circuitId],
                           let es = existing.date,
                           let raceDate = isoFormatter.date(from: es),
                           raceDate > date {
                        } else {
                            lastPastRaceByCircuit[circuitId] = race
                        }
                    } else {
                        
                        if let existing = nextFutureRaceByCircuit[circuitId],
                           let es = existing.date,
                           let ed = isoFormatter.date(from: es),
                           ed < date {
                        } else {
                            nextFutureRaceByCircuit[circuitId] = race
                        }
                    }
                }
                
                let pastRaces =  makeSchedule(schedule: lastPastRaceByCircuit, isofortematter: isoFormatter)
                let upcomingRaces = makeSchedule(schedule: nextFutureRaceByCircuit, isofortematter: isoFormatter)
                
                state = .loaded(pastRaces, upcomingRaces)
                
            }catch{
                state = .error
            }
        }
        
        func makeSchedule(schedule: [Int: ScheduleDataModel], isofortematter: ISO8601DateFormatter) -> [SchedulePageViewmodel] {
            
            schedule.values
                .compactMap { item -> (model: SchedulePageViewmodel, date: Date)? in
                    guard let dateStr = item.date, let date = isofortematter.date(from: dateStr) else { return nil }

                    let day = String(Calendar.current.component(.day, from: date))
                    let month = Calendar.current.component(.month, from: date).montNameMonth()
                    let comps = Calendar.current.dateComponents([.hour, .minute], from: date)
                    let year = Calendar.current.component(.year, from: date)
                    let hour = comps.hour ?? 0
                    let minute = comps.minute ?? 0

                    let model = SchedulePageViewmodel(model: ScheduleModel(
                        
                        id: item.id,
                        competition: .init(
                            id: item.competition.id,
                            name: item.competition.name,
                            location: .init(
                                country: item.competition.location.country,
                                city: item.competition.location.city
                            )
                        ),
                        circuit: .init(
                            id: item.circuit.id,
                            name: item.circuit.name,
                            image: item.circuit.assetForCircuitId(item.circuit.id)
                        ),
                        type: item.type.abreviation,
                        day: day,
                        month: month,
                        year: String(String(year).suffix(2)),
                        time: String(hour) + ":" + String(minute).addZero,
                        timezone: item.timezone,
                        status: item.status
                        
                        )
                    )
                    
                    return (model, date)
                }
                .sorted { $0.date < $1.date }
                .map { $0.model }
        }
    }
}
