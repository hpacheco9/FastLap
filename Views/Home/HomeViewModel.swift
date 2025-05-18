//
//  HomeViewModel.swift
//  F1 app
//
//  Created by Henrique Pacheco on 23/04/2025.
//

import Foundation
import Observation

@Observable
class HomeViewModel {
    
    enum State {
        case loading
        case loaded(DriverModel, SchedulePageViewmodel)
        case empty
        case error
    }
    
    struct Dependencies {
        let service: HomeServiceProtocol
    }
    
    private let dependencies: Dependencies
    var state: State = .loading
    
    init (dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func loadData() async {
        
        do {
            
            async let rankings =  try await dependencies.service.fetchRankings()
            async let schedule =  try await dependencies.service.fetchSchedule()
            
            let (races, drivers) = try await (schedule, rankings)

            
            guard !races.response.isEmpty else {
                state = .empty
                return
            }
            
            let scheduleResponses = races.response.compactMap({ $0 })
            
            let isoFormatter: ISO8601DateFormatter = {
                let f = ISO8601DateFormatter()
                f.formatOptions = [.withInternetDateTime]
                return f
            }()
            let now = Date()

            guard
                let nextRace = scheduleResponses
                    .compactMap({ race -> (Date, ScheduleAPIModel.Response)? in
                        guard
                            let ds = race.date,
                            let date = isoFormatter.date(from: ds),
                            date >= now
                        else { return nil }
                        return (date, race)
                    })
                    .min(by: { $0.0 < $1.0 })?
                    .1
            else {
                return
            }
            guard
                let ds = nextRace.date,
                let raceDate = isoFormatter.date(from: ds)
            else {
                return
            }

            let calendar = Calendar.current
            let day   = String(calendar.component(.day,   from: raceDate))
            let month = calendar.component(.month, from: raceDate).montNameMonth()
            let year  = calendar.component(.year,  from: raceDate)
            let hour  = calendar.component(.hour,  from: raceDate)
            let minute   = calendar.component(.minute,from: raceDate)
            
            let upcomingRace = SchedulePageViewmodel(model: ScheduleModel(
                id: nextRace.id,
                competition: ScheduleModel.Competition(
                    id: nextRace.competition.id ,
                    name: nextRace.competition.name,
                    location: ScheduleModel.Competition.Location(
                        country: nextRace.competition.location.country,
                        city: nextRace.competition.location.city
                    )
                ),
                circuit: ScheduleModel.Circuit(
                    id: nextRace.circuit.id,
                    name: nextRace.circuit.name,
                    image: nextRace.circuit.assetForCircuitId(nextRace.circuit.id)
                ),
                type: nextRace.type,
                day: day,
                month: month + " " + String(year).suffix(2),
                time: String(format: "%02d.%02d", hour, minute),
                timezone: nextRace.timezone,
                status: nextRace.status
            )
        )
            guard let driver = drivers.response.map({ response in
                DriverModel(
                    position: response.position,
                    driver: DriverModel.Driver(
                        id: response.driver.id,
                        name: response.driver.name,
                        number: response.driver.number,
                        abbreviation: response.driver.abbreviation,
                        imageUrl: response.driver.imageUrl
                    ),
                    team: DriverModel.Team(id: response.team.id, name: response.team.name, logo: response.team.assetForTeamId(response.team.id)),
                    points: response.points ?? 0,
                    wins: response.wins,
                    behind: response.behind,
                    season: response.season)
                
            }).first else {
                state = .empty
                return
            }
            
            state = .loaded(driver, upcomingRace)
        }
        catch {
            state = .error
        }
    }
}
    
    




