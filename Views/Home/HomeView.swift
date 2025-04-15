//
//  ContentView.swift
//  testev2
//
//  Created by Henrique Pacheco on 26/03/2025.
//

import SwiftUI

struct Home: View {
    
    let service = Homeservice(client:  APIClient(session: .init(configuration: .default)))
    
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
            
        ScrollView {
            VStack {
                Header(title: "Standings")
                    .onTapGesture {
                        coordinator.push(page: .standings)
                    }
                CardDriver(number: "4", action: {coordinator.presentSheet(sheet: .driverprofile)}, first: "Lando", last: "Norris", image: "lando", equipa: "mclaren").padding(.vertical, 10)
                Header(title: "header.upcoming".localized)
                    .onTapGesture {
                        coordinator.push(page: .shcedule)
                    }
                
                CardRace_(Race: "Circuit de Barcelona-Catalunya", GP: "GP Japan", Day: "06", Time:"9.30 AM", Month: "April '25",Number: 25, type: "Race", image: "Barca", flag: "JP", action: {}, Status: .soon).padding(.vertical, 10)
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.large)
            .frame(maxHeight: .infinity)
            .task {
                
                let standings = try? await service.fetchRankings()
                print(standings ?? "")
                
            }
        }
        
    }
}

#Preview {
    @Previewable @EnvironmentObject var coordinator: Coordinator
    
    Home()
}


