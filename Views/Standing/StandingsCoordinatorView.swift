//
//  StandingsCoordinatorView.swift
//  F1 app
//
//  Created by Henrique Pacheco on 15/04/2025.
//

import SwiftUI

struct StandingsCoordinatorView: View {
    
    
    @EnvironmentObject var coordinator: Coordinator
    var body: some View {
        
        NavigationStack(path: $coordinator.path){
            coordinator.build(page: .standings)
                .navigationDestination(for: Page.self){ page in
                    coordinator.build(page: page)
                }
                .sheet(item: $coordinator.sheet) { sheet in
                    coordinator.build(sheet: sheet)
                }
        }
        
    }
}

#Preview {
    StandingsCoordinatorView()
        .environmentObject(Coordinator())
}
