//
//  HomeCoordinatorView.swift
//  testev2
//
//  Created by Henrique Pacheco on 08/04/2025.
//

import SwiftUI

struct HomeCoordinatorView: View {
    
    @EnvironmentObject private var coordinator : Coordinator
    
    var body: some View {
        NavigationStack(path: $coordinator.path){
            coordinator.build(page: .home)
                .navigationDestination(for: Page.self){ page in
                    coordinator.build(page: page)
            }
        }
    }
}

#Preview {
    
    HomeCoordinatorView()
        .environmentObject(Coordinator())
}
