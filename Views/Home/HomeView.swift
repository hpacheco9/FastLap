//
//  ContentView.swift
//  testev2
//
//  Created by Henrique Pacheco on 26/03/2025.
//

import SwiftUI

struct Home: View {
    
    
    var viewModel: HomeViewModel

    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
       VStack {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .loaded(let driver, let schedule):
                ScrollView {
                    VStack {
                        Header(title: "Standings")
                            .padding(.horizontal, 5)
                            .onTapGesture {
                                coordinator.push(page: .standings)
                            }
                           
                        CardDriver(driver: driver)
                            .padding(.vertical, -15)
                            .onTapGesture {
                                coordinator.push(page: .driverprofile)
                        }
                            
                        
                        Header(title: "header.upcoming".localized)
                            .padding(.horizontal, 5)
                            .onTapGesture {
                                coordinator.push(page: .shcedule)
                            }
                        
                        CardRace_(schedule: schedule , status: .live).padding(10).padding(.vertical, -15)
                            
                    }
                    .navigationTitle("Home")
                    .navigationBarTitleDisplayMode(.inline)
                    .frame(maxHeight: .infinity)
                  
                }
            case .empty:
                EmptyView()
            case .error:
                EmptyView()
            }
        }
       .task {
         // await viewModel.loadData()
       }
    }
}

#Preview {
    @Previewable @EnvironmentObject var coordinator: Coordinator
    Home(
        viewModel: HomeViewModel(
            dependencies: .init(
                service: Homeservice(client: APIClient(session: URLSession(configuration: .default)))
            )
        )
    )
}


