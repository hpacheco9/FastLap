//
//  StandingsCoordinatorView.swift
//  F1 app
//
//  Created by Henrique Pacheco on 15/04/2025.
//

import SwiftUI

struct StandingsCoordinatorView: View {
    
    
    @EnvironmentObject var coordinator: Coordinator
    var viewmodel: StandingsViewModel
    var body: some View {
        
        NavigationStack(path: $coordinator.path){
            coordinator.build(page: .standings(viewmodel: viewmodel))
                .navigationDestination(for: Page.self){ page in
                    coordinator.build(page: page)
            }
        }
    }
}

