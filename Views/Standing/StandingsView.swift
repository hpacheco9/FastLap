//
//  Standings.swift
//  testev2
//
//  Created by Henrique Pacheco on 07/04/2025.
//

import SwiftUI

struct Standings: View {
    
    let viewModel: StandingsViewModel
    
    init(viewModel: StandingsViewModel) {
        UISegmentedControl.appearance().selectedSegmentTintColor = .orange
        self.viewModel = viewModel
    }
   
    @State private var type: StandingTypes = .drivers
    
    var body: some View {
        
        VStack {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .loaded(let drivers, let teams):
                VStack {
                    Picker("Type", selection: $type) {
                        ForEach(StandingTypes.allCases, id: \.self){
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    
                    StandingsView(standingsType: type, drivers: drivers, teams: teams)
                }
                .frame(alignment: .top)
                .navigationTitle("Standings")
                .toolbarTitleDisplayMode(.inline)
            case .empty:
                EmptyView()
            case .error:
                EmptyView()
            }
        }
        .task {
            await viewModel.loadData()
            
           
         }
    }
}


#Preview {
 
    Standings(viewModel:StandingsViewModel(
                    dependencies: .init(
                        service: StandingsService(client: APIClient(session: URLSession(configuration: .default))))))
}
