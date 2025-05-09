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
    
    init (dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func loadData() async {
        
        do {
            
            let data = try await dependencies.service.fetchTeamsRankings()
            
            guard data.response.isEmpty else {
                state = .empty
                return
            }
            
            let teams = data.response.map{ response in
                TeamModel(
                    id: response.team.id,
                    position: response.position,
                    points: response.points,
                    name: response.team.name,
                    logo: response.team.assetForTeamId(response.team.id))
            }

            let rankings =  try await dependencies.service.fetchDriversRankings()
            
            
            guard !rankings.response.isEmpty else {
                state = .empty
                return
            }

            let driver = rankings.response.map { response in
                
                
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
                
            }
            
            state = .loaded(driver, teams)
        }
        catch {
            state = .error
        }
    }
}
