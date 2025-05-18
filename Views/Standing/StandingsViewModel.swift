//
//  StandingsViewModel.swift
//  F1 app
//
//  Created by Henrique Pacheco on 30/04/2025.
//

import Foundation

@Observable
class StandingsViewModel {
    
    enum State {
        case loading
        case loaded([DriverModel], [TeamModel])
        case empty
        case error
    }
    
    struct Dependencies {
        let service: StandingsServiceProtocol
    }
    
    private let dependencies: Dependencies
    var state: State = .loading
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func loadData() async {
        state = .loading
        
        do {
            
            async let teamsData = dependencies.service.fetchTeamsRankings()
            async let driversData = dependencies.service.fetchDriversRankings()
            let (teamResponse, driverResponse) = try await (teamsData, driversData)
            
            
            guard !teamResponse.response.isEmpty else {
                state = .empty
                return
            }
            
            guard !driverResponse.response.isEmpty else {
                state = .empty
                return
            }
            
            
            let teams = teamResponse.response.map { item in
                TeamModel(
                    id: item.team.id,
                    position: item.position,
                    points: item.points,
                    name: item.team.name,
                    logo: item.team.assetForTeamId(item.team.id)
                )
            }
            
            
            let drivers = driverResponse.response.map { item in
                DriverModel(
                    position: item.position,
                    driver: .init(
                        id: item.driver.id,
                        name: item.driver.name,
                        number: item.driver.number,
                        abbreviation: item.driver.abbreviation,
                        imageUrl: item.driver.imageUrl
                    ),
                    team: .init(
                        id: item.team.id,
                        name: item.team.name,
                        logo: item.team.assetForTeamId(item.team.id)
                    ),
                    points: item.points ?? 0,
                    wins: item.wins,
                    behind: item.behind,
                    season: item.season
                )
            }
            
            state = .loaded(drivers, teams)
            
        } catch {
            state = .error
        }
    }
}
