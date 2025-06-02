//
//  RaceStandingsViewmodel.swift
//  F1 app
//
//  Created by Henrique Pacheco on 26/05/2025.
//

import Foundation


@Observable
class RaceStandingsViewmodel {
    enum State {
        case loading
        case loaded([RaceStandingsPageViewmodel])
        case empty
        case error
    }
    
    struct Dependencies {
        let service: RaceRankingsServiceProtocol
        let race: String
    }
    
    private let dependencies: Dependencies
    var state: State = .loading
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    @MainActor
    func loadData() async  {
        
        
        do {
            
            guard !dependencies.race.isEmpty else {
                print("no race")
                state = .empty
                return
            }
            
            let rankings = try await dependencies.service.fetchRaceRankings(race: dependencies.race)

            
            guard !rankings.response.isEmpty else {
                state = .empty
                return
            }
            
            let results: [RaceStandingsPageViewmodel] = rankings.response.map{ result in
                let abbr = result.driver.abbreviation ?? result.driver.name
                    .split(separator: " ", maxSplits: 1)
                    .first
                    .map { String($0.prefix(3)).uppercased() } ?? ""


                return RaceStandingsPageViewmodel(model:
                    RaceStandings(id: result.driver.id,
                                  name: result.driver.name,
                                  position: result.position,
                                  abbreviation: abbr,
                                  time: result.time,
                                  color: result.team.assetForTeamId(result.team.id).1)
                )
            }
            
            
            state = .loaded(results)
            
        } catch {
            state = .error
        }
    }
}
