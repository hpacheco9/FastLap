//
//  ScheduleView.swift
//  testev2
//
//  Created by Henrique Pacheco on 10/04/2025.
//

import SwiftUI

struct ScheduleView: View {
    var  scheduleTypes: ScheduleTypes
    
    var body: some View {
        
        switch scheduleTypes {
        case .upcoming:
            ScrollView {
                LazyVStack {
                    ForEach(1..<21) { index in
                        CardRace_(Race: "Circuit de Barcelona-Catalunya", GP: "GP Japan", Day: "06", Time:"9.30 AM", Month: "April 25'", Number: 25, type: "FP2", image: "canada", flag: "JP", action: {}, Status: .soon)
                            .padding(.vertical, 20)
                    }
                }
            }
            
        case .past:
            ScrollView {
                LazyVStack {
                    CardRace_(Race: "Circuit de Barcelona-Catalunya", GP: "GP Japan", Day: "06", Time:"9.30 AM", Month: "April 25'", Number: 25, type: "FP2", image: "japan", flag: "JP", action: {}, Status: .live)
                        .padding(.vertical, 25)
                }
            }
        }
    }
}


enum ScheduleTypes: String, CaseIterable {
    case upcoming = "Upcoming"
    case past = "Past"
}

#Preview {
    ScheduleView(scheduleTypes: .upcoming)
}
