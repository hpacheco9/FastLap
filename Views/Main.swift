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
    
    
    var body: some View {
        
        if !isFirstLaunch {
            TabView(selection: $selectedTab) {
                HomeCoordinatorView()
                    .environmentObject(Coordinator())
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }.tag(0)
                
                ScheduleCoordinatorView()
                    .environmentObject(Coordinator())
                    .tabItem {
                        Label("Schedule", systemImage: "flag.pattern.checkered.2.crossed")
                    }.tag(1)
                
                StandingsCoordinatorView()
                    .environmentObject(Coordinator())
                    .tabItem {
                        Label("Standings", systemImage:"trophy")
                    }.tag(2)
            }
            .accentColor(.primary)
            .transition(.slide)
            
        }else {
            
            Onboarding()
            
        }
    }
}



#Preview {
    Main()
}
