//
//  DriversColletion.swift
//  testev2
//
//  Created by Henrique Pacheco on 07/04/2025.
//

import SwiftUI

struct DriversColletion: View {
    
    @EnvironmentObject var coordinator: Coordinator
    
    let driverModel = DriverModel(
        position: 1,
        driver: DriverModel.Driver(
            id: 1,
            name: "Max Verstappen",
            number: 33,
            abbreviation: "VER",
            imageUrl: "teste"
        ),
        team: DriverModel.Team(id: 1, name: "Red Bull Racing", logo: "Teste"),
        points: 55,
        wins: 3,
        behind: 0,
        season: 2023)
    
    var body: some View {
        ScrollView(showsIndicators: false){
            LazyVStack {
                ForEach(1..<21) { index in
                   
                    CardDriver(driver: driverModel)
                    
                }
            }
        }
    }
}

#Preview {
    DriversColletion()
}
