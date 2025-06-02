//
//  StandingsViewModel.swift
//  F1 app
//
//  Created by Henrique Pacheco on 30/04/2025.
//

import Foundation
import Observation

@Observable
class StandingsViewModel {
    
    enum State {
        case loading
        case loaded([DriverPageViewmodel], [TeamPageViewmodel])
        case empty
        case error
    }
    
    struct Dependencies {
        let service: StandingsServiceProtocol
    }
    
    private let dependencies: Dependencies
    var state: State = .loading
    
    let title = LocalizationKey.Title.standings.localized
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    @MainActor
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
                TeamPageViewmodel(model:  TeamModel(
                    id: item.team.id,
                    position: item.position,
                    points: item.points,
                    name: item.team.name,
                    logo: item.team.assetForTeamId(item.team.id).0,
                    color: item.team.assetForTeamId(item.team.id).1
                ))
            }
            
            
            let drivers = driverResponse.response.map { item in
                
                DriverPageViewmodel(model:  DriverModel(
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
                        logo: item.team.assetForTeamId(item.team.id).0,
                        color: item.team.assetForTeamId(item.team.id).1
                    ),
                    points: item.points ?? 0,
                    wins: item.wins,
                    behind: item.behind,
                    season: item.season
                ))
            }
            
            state = .loaded(drivers, teams)
            
        } catch {
            state = .error
        }
    }
}
