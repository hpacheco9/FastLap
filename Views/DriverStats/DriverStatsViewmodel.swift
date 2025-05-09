//
//  DriverStatsViewmodel.swift
//  F1 app
//
//  Created by Henrique Pacheco on 07/05/2025.
//

import Foundation

@Observable
class DriverStatsViewmodel {

    enum State {
        case loading
        case loaded(DriverProfilePageViewmodel)
        case empty
        case error
    }
    
    struct Dependencies {
        let service: DriverStatsServiceProtocol
        let driver: DriverModel?
    }
    
    private let dependencies: Dependencies
    var state: State = .loading
    
    init (dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    
    func loadData() async {

        guard let currentDriver = dependencies.driver else {
            state = .error
            return
        }

        print(currentDriver)
        
        do {
            
            let driverIdString = String(currentDriver.driver.id)
            let data = try await dependencies.service.fetchDriver(id: driverIdString)

            guard let first = data.response.first else {
                state = .empty
                return
            }
            let driver = DriverProfilePageViewmodel(
                model: DriverStatsModel(
                    id: first.id,
                    name: first.name,
                    image: first.imageUrl,
                    number: first.number,
                    country: first.country.name,
                    position: currentDriver.position,
                    points: currentDriver.points ?? 0,
                    wins: first.total_wins.number,
                    podiums: first.podiums ?? 0,
                    team: .init(
                        id: first.teams.first?.team.id ?? 0,
                        name: first.teams.first?.team.name ?? "",
                        logo: first.teams.first?.team
                            .assetForTeamId(first.teams.first?.team.id ?? 0) ?? ""
                    ),
                    worldChampionships: first.championships ?? 0,
                    gpEntries: first.grands_prix_entered ?? 0
                )
            )

            
            state = .loaded(driver)
        }
        catch {
            
            state = .error
        }
    }

    
}
