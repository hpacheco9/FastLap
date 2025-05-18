//
//  DriversColletion.swift
//  testev2
//
//  Created by Henrique Pacheco on 07/04/2025.
//

import SwiftUI

struct DriversColletion: View {
    
    
    @EnvironmentObject private var coordinator: Coordinator
    let drivers: [DriverModel]
    
    var body: some View {
        ScrollView(showsIndicators: false){
            LazyVStack {
                ForEach(drivers, id: \.driver.id) { driver in
                    CardDriver(driver: driver).onTapGesture {
                        coordinator.present(sheet: .driverprofile(viewModel: DriverStatsViewmodel(
                         dependencies:
                                 .init(
                                     service: DriverStatsService(client: APIClient(session: URLSession(configuration: .default))), driver: driver))))
                    }
                }
            }
        }
    }
}



#Preview {
    DriversColletion(drivers: [
            DriverModel(
                position: 1,
                driver: DriverModel.Driver(
                    id: 1,
                    name: "Max Verstappen",
                    number: 1,
                    abbreviation: "VER",
                    imageUrl: "https://example.com/verstappen.jpg"
                ),
                team: DriverModel.Team(id: 3, name: "Red Bull Racing", logo: "redbull_logo"),
                points: 395,
                wins: 7,
                behind: 0,
                season: 2025
            )
        ])
        
}
