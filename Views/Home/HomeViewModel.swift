//
//  HomeViewModel.swift
//  F1 app
//
//  Created by Henrique Pacheco on 23/04/2025.
//

import Foundation


@Observable
class HomeViewModel {
    
    enum State {
        case loading
        case loaded(DriverPageViewmodel, SchedulePageViewmodel?)
        case empty
        case error
    }
    
    struct Dependencies {
        let service: HomeServiceProtocol
        
    }
    
    let headerUpcoming = LocalizationKey.Header.upcoming.localized
    let headerStandings = LocalizationKey.Header.standings.localized
    let title = LocalizationKey.Title.home.localized
    let buttonSeeAll = LocalizationKey.Button.seeall.localized
    
    
    private let dependencies: Dependencies
    var state: State = .loading
    
    init (dependencies: Dependencies) {
        self.dependencies = dependencies

    }
    
    @MainActor
    func loadData() async {
        do {
            async let rankings =  try await dependencies.service.fetchRankings()
            async let schedule =  try await dependencies.service.fetchSchedule()
            
            let (drivers, races) = try await (rankings, schedule)
            
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

            let nextRace = scheduleResponses.compactMap({ race -> (Date, ScheduleAPIModel.Response)? in
                    guard let ds = race.date,
                    let date = isoFormatter.date(from: ds),
                    date >= now
                    else { return nil }
                    return (date, race)
                })
                .min(by: { $0.0 < $1.0 })?
                .1
                
                var upcomingRace: SchedulePageViewmodel? = nil
            
                if let nextRace = nextRace,
                   let ds = nextRace.date,
                   let raceDate = isoFormatter.date(from: ds) {
                    
                    let calendar = Calendar.current
                    let day   = String(calendar.component(.day,   from: raceDate))
                    let month = calendar.component(.month, from: raceDate).montNameMonth()
                    let year  = calendar.component(.year,  from: raceDate)
                    let hour  = calendar.component(.hour,  from: raceDate)
                    let minute   = calendar.component(.minute,from: raceDate)
                    
                    upcomingRace = SchedulePageViewmodel(model: ScheduleModel(
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
                        type: nextRace.type.abreviation,
                        day: day,
                        month: month,
                        year: String(String(year).suffix(2)),
                        time: String(hour) + ":" + String(minute).addZero,
                        timezone: nextRace.timezone,
                        status: nextRace.status
                    ))
                }
            
            guard let driver = drivers.response.map({ response in
               DriverPageViewmodel(model:  DriverModel(
                    position: response.position,
                    driver: DriverModel.Driver(
                        id: response.driver.id,
                        name: response.driver.name,
                        number: response.driver.number,
                        abbreviation: response.driver.abbreviation,
                        imageUrl: response.driver.imageUrl
                    ),
                    team: DriverModel.Team(id: response.team.id, name: response.team.name, logo: response.team.assetForTeamId(response.team.id).0, color: response.team.assetForTeamId(response.team.id).1),
                    points: response.points ?? 0,
                    wins: response.wins,
                    behind: response.behind,
                    season: response.season))
                
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
    
