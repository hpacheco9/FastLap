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
               VStack {
                 EmptyHomeView()
               }
               
            case .loaded(let driver, let schedule):
                ScrollView {
                    VStack {
                        Header(title: viewModel.headerStandings, buttonTitle: viewModel.buttonSeeAll)
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
                        
                        Header(title: viewModel.headerUpcoming, buttonTitle: viewModel.buttonSeeAll)
                            .padding(.horizontal, 5)
                            .onTapGesture {
                                coordinator.push(page: .shcedule(viewmodel: ScheduleViewModel(
                                    dependencies: .init(
                                        service: ScheduleService(client: APIClient(session: URLSession(configuration: .default)))))))
                            }
                        
                        
                        CardRace_(schedule: schedule, status: .live).padding(10).padding(.vertical, -15)
                                .onTapGesture {
                                    guard let competitionId = schedule?.id else {
                                        return
                                    }
                                    coordinator.present(sheet: .results(
                                        viewModel: RaceStandingsViewmodel(
                                            dependencies: .init(
                                                service: RaceRankingsService(client: APIClient(session: URLSession(configuration: .default))),
                                                race: String(competitionId)
                                            )
                                        )
                                    )
                                )
                                }
                                .emptyContent(isEmpty: schedule == nil) {
                                    NoSchedule()
                                    .padding(.vertical, -15)
                        }
                    }
                }
            case .empty:
                EmptyView()
            case .error:
               EmptyView()
            }
       }.onAppear {
           Task {
              await viewModel.loadData()
           }
       }
       .navigationTitle(viewModel.title)
       .accessibilityAddTraits(.isHeader)
       .navigationBarTitleDisplayMode(.inline)
       .frame(maxHeight: .infinity)
    }
}

#Preview {
    Home(
        viewModel: HomeViewModel(
            dependencies: .init(
                service: Homeservice(client: APIClient(session: URLSession(configuration: .default)))
            )
        )
    )
    .environmentObject(Coordinator())
}
