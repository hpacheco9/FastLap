//
//  ScheduleCoordinatorView.swift
//  F1 app
//
//  Created by Henrique Pacheco on 15/04/2025.
//

import SwiftUI

struct ScheduleCoordinatorView: View {
    
    @EnvironmentObject var coordinator: Coordinator
    var viewmodel: ScheduleViewModel
    
    var body: some View {
        
        NavigationStack(path: $coordinator.path){
            coordinator.build(page: .shcedule(viewmodel: viewmodel))
                .navigationDestination(for: Page.self){ page in
                    coordinator.build(page: page)
                }
                .sheet(item: $coordinator.sheet) { sheet in
                    coordinator.build(sheet: sheet)
            }
        }
    }
}


