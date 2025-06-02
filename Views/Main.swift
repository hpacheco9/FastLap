//
//  CustomTabBar.swift
//  testev2
//
//  Created by Henrique Pacheco on 07/04/2025.
//

import SwiftUI

struct Main: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedTab: Int = 0
    @AppStorage("firsrLaunch") private var isFirstLaunch: Bool = true
 
    
    var scheduleViewmodel: ScheduleViewModel = ScheduleViewModel(
        dependencies: .init(
            service: ScheduleService(client: APIClient(session: URLSession(configuration: .default)))))
    
    var home = HomeViewModel(
        dependencies: .init(
            service: Homeservice(client: APIClient(session: URLSession(configuration: .default)))
        )
    )
    
    var standings = StandingsViewModel(
        dependencies: .init(
            service: StandingsService(client: APIClient(session: URLSession(configuration: .default)))
        )
      )
    
    
    var body: some View {
        
        if isFirstLaunch {
            Onboarding()
            
        } else {
           
            TabView(selection: $selectedTab) {
                
                HomeCoordinatorView(viewmodel: home)
                    .environmentObject(Coordinator())
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }.tag(0)
                
                ScheduleCoordinatorView(viewmodel: scheduleViewmodel)
                    .environmentObject(Coordinator())
                    .tabItem {
                        Label("Schedule", systemImage: "flag.pattern.checkered.2.crossed")
                    }.tag(1)
                
                StandingsCoordinatorView(viewmodel: standings)
                    .environmentObject(Coordinator())
                    .tabItem {
                        Label("tab.bar.standings".localized, systemImage:"trophy")
                    }.tag(2)
            }
            .accentColor(.primary)
            .transition(.slide)
            
        }
    }
}



#Preview {
    Main()
}
