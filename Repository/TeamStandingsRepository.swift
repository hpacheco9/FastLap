//
//  TeamStandingsRepository.swift
//  F1 app
//
//  Created by Henrique Pacheco on 06/06/2025.
//

import Foundation
import SwiftData


protocol TeamStandingsRepositoryProtocol {
    func fetchStandingsTeams(season: Int) throws -> [TeamStandingsDataModel]
    func fetchTeam(season: Int, id: Int) throws -> TeamStandingsDataModel?
    func insertTeams(teamStandings: [TeamRankingsAPIModel.Response], season: Int) throws -> [TeamStandingsDataModel]
}

class TeamStandingsRepository {
    var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
}

extension TeamStandingsRepository: TeamStandingsRepositoryProtocol {
    func fetchStandingsTeams(season: Int) throws -> [TeamStandingsDataModel]{
        let predicate = #Predicate<TeamStandingsDataModel> { $0.season == season }
        let descriptor = FetchDescriptor<TeamStandingsDataModel>(
            predicate: predicate,
            sortBy: [SortDescriptor(\.position)]
        )
        let fetchedStandings = try modelContext.fetch(descriptor)
    
        return fetchedStandings
    }
    
    func fetchTeam(season: Int, id: Int) throws -> TeamStandingsDataModel? {
        let predicate = #Predicate<TeamStandingsDataModel> { $0.season == season  && $0.team.id == id}
        let descriptor = FetchDescriptor<TeamStandingsDataModel>(
            predicate: predicate,
        )
        let fetchedTeam = try modelContext.fetch(descriptor).first
        return fetchedTeam
    }
    
    func fetchTeamById(_ id: Int) throws -> Team? {
        let predicate = #Predicate<Team> { $0.id == id }
        let descriptor = FetchDescriptor<Team>(predicate: predicate)
        return try modelContext.fetch(descriptor).first
    }

    
    func insertTeams(teamStandings: [TeamRankingsAPIModel.Response], season: Int) throws -> [TeamStandingsDataModel] {
        guard !teamStandings.isEmpty else { throw RepositoryError.emptyContent }

        for response in teamStandings {
            let existing = try fetchTeam(season: response.season, id: response.team.id)
            let teamLogo = response.team.assetForTeamId(response.team.id).0
            
            var team: Team
            
            if let existing = existing {
                team = existing.team
                team.logo = teamLogo
                existing.position = response.position
                existing.points = response.points
            } else {
                if let existingTeam = try fetchTeamById(response.team.id) {
                    team = existingTeam
                    team.logo = teamLogo
                } else {
                    team = Team(id: response.team.id, name: response.team.name, logo: teamLogo)
                    modelContext.insert(team)
                }
                
                let newEntry = TeamStandingsDataModel(
                    position: response.position,
                    team: team,
                    points: response.points,
                    season: response.season
                )
                modelContext.insert(newEntry)
            }
        }


        do {
            try modelContext.save()
        } catch {
            print("Erro ao salvar: \(error)")
        }

        return try fetchStandingsTeams(season: season)
    }
}
