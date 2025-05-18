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
                                coordinator.push(page: .standings(viewmodel:
                                                                   StandingsViewModel(
                                                                        dependencies: .init(
                                                                            service: StandingsService(client: APIClient(session: URLSession(configuration: .default)))))))
                            }
                           
                       CardDriver(driver: driver)
                            .padding(.vertical, -15)
                            .onTapGesture {
                                coordinator.present(sheet: .driverprofile(viewModel: DriverStatsViewmodel(
                                 dependencies:
                                         .init(
                                             service: DriverStatsService(client: APIClient(session: URLSession(configuration: .default))), driver: driver))))
                        }
                        
                        Header(title: "header.upcoming".localized)
                            .padding(.horizontal, 5)
                            .onTapGesture {
                                coordinator.push(page: .shcedule(viewmodel: ScheduleViewModel(
                                    dependencies: .init(
                                        service: ScheduleService(client: APIClient(session: URLSession(configuration: .default)))))))
                            }
                        
                       CardRace_(schedule: schedule , status: .live).padding(10).padding(.vertical, -15)
                    }
                }
            case .empty:
                EmptyView()
            case .error:
               EmptyView()
            }
       }.onAppear {
           Task {
              // await viewModel.loadData()
           }
       }
       .navigationTitle("Home")
       .navigationBarTitleDisplayMode(.inline)
       .frame(maxHeight: .infinity)
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


