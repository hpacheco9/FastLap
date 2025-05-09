//
//  ScheduleView.swift
//  testev2
//
//  Created by Henrique Pacheco on 10/04/2025.
//

import SwiftUI

struct ScheduleView: View {
    
    var  scheduleTypes: ScheduleViewModel.ScheduleTypes
    
    @EnvironmentObject private var coordinator: Coordinator
    
    var pastRaces: [SchedulePageViewmodel]
    
    var upcomingRaces: [SchedulePageViewmodel]
    
    var body: some View {
        
        switch scheduleTypes {
        case .upcoming:
            ScrollView(showsIndicators: false){
                LazyVStack {
                    ForEach(upcomingRaces, id: \.id) { race in
                       CardRace_(schedule: race, status: .soon)
                            .padding(.vertical, 0)
                            .padding(10)
                            
                    }
                }
            }
            
        case .past:
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(pastRaces, id: \.id) { race in
                       CardRace_(schedule: race, status: .soon)
                            .padding(.vertical, 0)
                            .padding(10)
                    }

                }
            }
        }
    }
}




#Preview {
   // ScheduleView(scheduleTypes: .upcoming)
}
