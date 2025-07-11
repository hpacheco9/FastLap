//
//  ContentView.swift
//  testev2
//
//  Created by Henrique Pacheco on 26/03/2025.
//

import SwiftUI
import SwiftData

struct Home: View {
    
    var viewModel: HomeViewModel

    @EnvironmentObject private var coordinator: Coordinator
    @Environment(\.modelContext) private var modelContext
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
                        Header(title: viewModel.headerStandings, buttonTitle: viewModel.buttonSeeAll,
                               action: {coordinator.push(page: .standings(viewmodel: StandingsViewModel(
                                        dependencies: .init( service: StandingsService(client: APIClient(session: URLSession(configuration: .default)),
                                                standingsREpository: StandingsRepository(
                                                driverRepository: DriverStandingsRepository(modelContext: modelContext),
                                                teamStandings: TeamStandingsRepository(modelContext: modelContext)
                                                )
                                            )
                                        )
                                    )
                                 )
                             )})
                            .padding(.horizontal, 5)
                           
                        CardDriver(driver: driver)
                            .padding(.vertical, -15)
                            .onTapGesture {
                                coordinator.present(sheet: .driverprofile(viewModel: DriverStatsViewmodel(
                                 dependencies:
                                         .init(
                                             service: DriverStatsService(client: APIClient(session: URLSession(configuration: .default))), driver: driver))))
                        }
                        
                        Header(title: viewModel.headerUpcoming, buttonTitle: viewModel.buttonSeeAll, action: {coordinator.push(page: .shcedule(viewmodel: ScheduleViewModel(
                            dependencies: .init(
                                service: ScheduleService(client: APIClient(session: URLSession(configuration: .default)), scheduleRepository: ScheduleRepository(modelContext: modelContext)))
                        )))})
                            .padding(.horizontal, 5)
                           
                        
                        
                        CardRace_(schedule: schedule).padding(10).padding(.vertical, -15)
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
               VStack {
                   Text("Error")
               }
               
            }
       }.onAppear {
           Task {
              await viewModel.loadData()
           }
       }
       .toolbar {
           ToolbarItem(placement: .topBarTrailing) {
               Button(action: {
                   viewModel.requestNotificationPermission()
               }) {
                   Image(systemName: viewModel.notificationsEnabled ?  "bell.fill" : "bell.slash" )
               }
           }
       }

       .navigationTitle(viewModel.title)
       .accessibilityAddTraits(.isHeader)
       .navigationBarTitleDisplayMode(.inline)
       .frame(maxHeight: .infinity)
    }
}

#Preview {
     @Previewable @Environment(\.modelContext) var modelContext
    Home(
        viewModel: HomeViewModel(
            dependencies: .init(
                service: Homeservice(client: APIClient(session: URLSession(configuration: .default)),
                                     homeRepository: HomeRepository(standingsRepsitory: DriverStandingsRepository(modelContext: modelContext), scheduleRepository: ScheduleRepository(modelContext: modelContext))), notificationService: NotificationService(notification: UNUserNotificationCenter.current())
            )
        )
    )
    .environmentObject(Coordinator())
}
