//
//  DriversColletion.swift
//  testev2
//
//  Created by Henrique Pacheco on 07/04/2025.
//

import SwiftUI

struct DriversColletion: View {
    
    
    @EnvironmentObject private var coordinator: Coordinator
    let drivers: [DriverPageViewmodel]
    
    var body: some View {
        ScrollView(showsIndicators: false){
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


