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
        case loaded(DriverModel, ScheduleModel)
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
    
    
    func reloadData() async {
        let schedule = try? await dependencies.service.fetchSchedule()
        print(schedule ?? "Schedule not found")
    }
    
    func loadData() async {
        
        do {
            
            let rankings =  try await dependencies.service.fetchRankings()
            let schedule =  try await dependencies.service.fetchSchedule()

            guard let lastResponse = schedule.response.last else {
                self.state = .empty
                return
            }
            
            let formatter = ISO8601DateFormatter()
            let date = formatter.date(from: lastResponse?.date ?? "")
            let day = String(Calendar.current.component(.day, from: date ?? Date()))
            let month = Calendar.current.component(.month, from: date ?? Date()).montNameMonth()
            
            let lastSchedule = ScheduleModel(
                id: lastResponse?.id  ?? 0,
                competition: ScheduleModel.Competition(id: lastResponse?.competition.id ?? 0, name: lastResponse?.competition.name ?? "", location: ScheduleModel.Competition.Location(country: lastResponse?.competition.location.country ?? "", city: lastResponse?.competition.location.country ?? "")),
                
                circuit: ScheduleModel.Circuit(id: lastResponse?.circuit.id ?? 0, name: lastResponse?.circuit.name ?? "", image: lastResponse?.circuit.assetForCircuitId(lastResponse?.circuit.id ?? 0) ?? ""),
                type: lastResponse?.type ?? "",
                day: day,
                month: month,
                timezone: lastResponse?.timezone ?? "",
                status: lastResponse?.status ?? ""
            )


            guard let driver = rankings.response.map({ response in
        
                
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

            
            
            
            
            state = .loaded(driver, lastSchedule)
            
        }
        catch {
            state = .error
        }
    }
}
    
    




