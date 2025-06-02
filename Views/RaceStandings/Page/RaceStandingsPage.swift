//
//  RaceStandingsPage.swift
//  F1 app
//
//  Created by Henrique Pacheco on 26/05/2025.
//

import SwiftUI

struct RaceStandingsPage: View {
    
    var viewmodel: RaceStandingsViewmodel
    
    var body: some View {
        VStack {
            switch viewmodel.state {
            case .loading:
                ProgressView()
            case .loaded(let results):
                ResultsHeader()
                ScrollView(showsIndicators: false) {
                    ForEach(results, id: \.id) { result in
                        RaceResults(standing: result)
                    }
                }
            case.empty:
                Text("No results")
            case .error:
                Text("Error")
            }
        }.task {
            await viewmodel.loadData()
        }
         .navigationTitle("Results")
        
    }
}

#Preview {
    RaceStandingsPage(viewmodel: RaceStandingsViewmodel(
        dependencies: .init(
            service: RaceRankingsService(client: APIClient(session: URLSession(configuration: .default))), race: "1671"
        )
     ))
}
