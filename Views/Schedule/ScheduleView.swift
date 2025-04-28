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
            ScrollView(showsIndicators: false){
                LazyVStack {
                    ForEach(1..<21) { index in
                        
                        
                        CardRace_(schedule: ScheduleModel(
                            id: 1671,
                            competition: ScheduleModel.Competition(
                                id: 2,
                                name: "Bahrain Grand Prix",
                                location: ScheduleModel.Competition.Location(
                                    country: "Bahrain",
                                    city: "Sakhir"
                                )
                            ),
                            circuit: ScheduleModel.Circuit(
                                id: 2,
                                name: "Bahrain International Circuit", image: "ChinaGP",
                            ),
                            type: "Race",
                            day: "07",
                            month: "March",
                            timezone: "utc",
                            status: "Completed"
                        ), status: .live).padding(.vertical, 0).padding(10)
                            
                    }
                }
            }
            
        case .past:
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    
                    CardRace_(schedule: ScheduleModel(
                        id: 1671,
                        competition: ScheduleModel.Competition(
                            id: 2,
                            name: "Bahrain Grand Prix",
                            location: ScheduleModel.Competition.Location(
                                country: "Bahrain",
                                city: "Sakhir"
                            )
                        ),
                        circuit: ScheduleModel.Circuit(
                            id: 2,
                            name: "Bahrain International Circuit",
                            image: "ChinaGP"
                        ),
                        type: "Race",
                        day: "10",
                        month: "April",
                        timezone: "utc",
                        status: "Completed"
                    ), status: .live).padding(.vertical, 0).padding(10)
                        
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
