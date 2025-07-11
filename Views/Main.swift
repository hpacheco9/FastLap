//
//  CustomTabBar.swift
//  testev2
//
//  Created by Henrique Pacheco on 07/04/2025.
//

import SwiftUI
import SwiftData

struct Main: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedTab: Int = 0
    @AppStorage("firsrLaunch") private var isFirstLaunch: Bool = true
    @Environment(\.modelContext) var modelContext
    
    @State private var scheduleViewModel: ScheduleViewModel?
    @State private var homeViewModel: HomeViewModel?
    @State private var standingsViewModel: StandingsViewModel?
    
    var body: some View {
        if isFirstLaunch {
            Onboarding()
        } else {
            TabView(selection: $selectedTab) {
                if let homeViewModel = homeViewModel {
                    HomeCoordinatorView(viewmodel: homeViewModel)
                        .environmentObject(Coordinator())
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }.tag(0)
                }
                
                if let scheduleViewModel = scheduleViewModel {
                    ScheduleCoordinatorView(viewmodel: scheduleViewModel)
                        .environmentObject(Coordinator())
                        .tabItem {
                            Label("Schedule", systemImage: "flag.pattern.checkered.2.crossed")
                        }.tag(1)
                }
                
                if let standingsViewModel = standingsViewModel {
                    StandingsCoordinatorView(viewmodel: standingsViewModel)
                        .environmentObject(Coordinator())
                        .tabItem {
                            Label("tab.bar.standings".localized, systemImage:"trophy")
                        }.tag(2)
                }
            }
            .accentColor(.primary)
            .transition(.slide)
            .onAppear {
                setupViewModels()
            }
        }
    }
    
    private func setupViewModels() {
        if scheduleViewModel == nil {
            scheduleViewModel = ScheduleViewModel(
                dependencies: .init(
                    service: ScheduleService(client: APIClient(session: URLSession(configuration: .default)),
                             scheduleRepository: ScheduleRepository(modelContext: modelContext))
                )
            )
        }
        
        if homeViewModel == nil {
            homeViewModel = HomeViewModel(
                dependencies: .init(
                    service: Homeservice(client: APIClient(session: URLSession(configuration: .default)),
                                         homeRepository: HomeRepository(standingsRepsitory: DriverStandingsRepository(modelContext: modelContext), scheduleRepository: ScheduleRepository(modelContext: modelContext))), notificationService: NotificationService(notification: UNUserNotificationCenter.current())
                )
            )
        }
        
        if standingsViewModel == nil {
            standingsViewModel = StandingsViewModel(
                dependencies: .init(
                    service: StandingsService(client: APIClient(session: URLSession(configuration: .default)),
                                            standingsREpository: StandingsRepository(driverRepository: DriverStandingsRepository(modelContext: modelContext),
                                                                                   teamStandings: TeamStandingsRepository(modelContext: modelContext)))
                )
            )
        }
    }
}


#Preview {
    Main()
}
