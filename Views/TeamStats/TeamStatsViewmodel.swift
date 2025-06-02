//
//  TeamStatsViewmodel.swift
//  F1 app
//
//  Created by Henrique Pacheco on 15/05/2025.
//

import Foundation


@Observable
class TeamStatsViewmodel {
    enum State {
        case loading
        case loaded(TeamStatsPageViewmodel)
        case empty
        case error
    }
    
    struct Dependencies {
        let service: TeamStatsServiceProtocol
        let team: TeamPageViewmodel?
    }
    
    private let dependencies: Dependencies
    var state: State = .loading
    
    init (dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    
    func loadData() async {

        guard let currentTeam = dependencies.team else {
            state = .error
            return
        }

        do {

            let data = try await dependencies.service.fetchTeam(id: String(currentTeam.id))
            
            guard !data.response.isEmpty else {
                state = .empty
                return
            }
            
            guard let item = data.response.first else {
                state = .empty
                return
            }
            
            let team = TeamStatsPageViewmodel(model:
                TeamStatsModel(id: item.id,
                               name: item.name,
                               logo: item.assetForTeamId(item.id).0,
                               position: currentTeam.position,
                               points: currentTeam.points,
                               totalWins: item.totalWins.number,
                               championships: item.championships,
                               poles: item.totalPoles ?? 0,
                               fastestLaps: item.totalFastestLaps ?? 0,
                               color:  item.assetForTeamId(item.id).1
                              )
            )
            
            state = .loaded(team)
        }
        catch {
            state = .error
        }
    }
}
