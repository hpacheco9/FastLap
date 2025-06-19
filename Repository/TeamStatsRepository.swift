//
//  TeamStatsRepository.swift
//  F1 app
//
//  Created by Henrique Pacheco on 12/06/2025.
//

import Foundation
import SwiftData


protocol TeamStatsRepositoryProtocol {
    func fetchTeamStats(teamId: Int) throws -> TeamStatsDataModel?
    func insertTeamStats(_ teamStats: TeamStatsModel) throws
}

class TeamStatsRepository {
    var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
}


extension TeamStatsRepository: TeamStatsRepositoryProtocol {
    func fetchTeamStats(teamId: Int) throws -> TeamStatsDataModel? {
        let predicate = #Predicate<TeamStatsDataModel> { $0.id == teamId }
        let descriptor = FetchDescriptor<TeamStatsDataModel>(
            predicate: predicate,
            sortBy: [SortDescriptor(\.position)]
        )
        
        return try modelContext.fetch(descriptor).first
    }
    
    func insertTeamStats(_ teamStats: TeamStatsModel) throws {
        
        let existing = try fetchTeamStats(teamId: teamStats.id)
        
        let team: TeamStatsDataModel
        if let existing = existing{
            team = existing
            team.name = teamStats.name
            team.points = teamStats.points
            team.position = teamStats.position
            team.wins = teamStats.totalWins
            team.championships = teamStats.championships
            team.poles = teamStats.poles
            team.fastestLaps =  teamStats.fastestLaps
            
        }else {
           team =  TeamStatsDataModel(
                id: teamStats.id,
                name: teamStats.name,
                logo: "",
                position: teamStats.position,
                points: teamStats.points,
        
                wins: teamStats.totalWins,
                poles: teamStats.poles,
                championships: teamStats.championships,
           
                fastestLaps: teamStats.fastestLaps
            )
            
            modelContext.insert(team)
        }
        
        do {
            try modelContext.save()
        } catch {
            print("Erro ao salvar: \(error)")
        }

    }
}
