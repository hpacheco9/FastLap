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
                VStack {
                    EmptyCard()
                    EmptyCard()
                }
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
               
            case .empty:
                EmptyView()
            case .error:
                EmptyView()
            }
        }
        .task {
             await viewModel.loadData()
        }
        .frame(alignment: .top)
        .navigationTitle(viewModel.title)
        .toolbarTitleDisplayMode(.inline)
    }
}
