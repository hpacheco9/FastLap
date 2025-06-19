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
    
    var client: RaceRankingsService = RaceRankingsService(client: APIClient(session:URLSession(configuration: .default)))
    
    var body: some View {
        switch scheduleTypes {
        case .upcoming:
            ScrollView(showsIndicators: false){
                LazyVStack {
                    ForEach(upcomingRaces, id: \.id) { race in
                        CardRace_(schedule: race)
                            .padding(.vertical, 0)
                            .padding(10)
                            .onTapGesture {
                                coordinator.present(sheet: .results(
                                    viewModel: RaceStandingsViewmodel(
                                        dependencies: .init(
                                            service: RaceRankingsService(client: APIClient(session: URLSession(configuration: .default))),
                                            race: String(race.id)
                                        )
                                    )
                                )
                            )
                        }
                    }
                }
            }.emptyContent(isEmpty: upcomingRaces.isEmpty){
                Text("No upcoming races")
                    .frame(maxHeight: .infinity, alignment: .center)
            }
            
        case .past:
            ScrollView(showsIndicators: false){
                LazyVStack {
                    ForEach(pastRaces, id: \.id) { race in
                        CardRace_(schedule: race)
                            .padding(.vertical, 0)
                            .padding(10)
                            .onTapGesture {
                                coordinator.present(sheet: .results(
                                    viewModel: RaceStandingsViewmodel(
                                        dependencies: .init(
                                            service: RaceRankingsService(client: APIClient(session: URLSession(configuration: .default))),
                                            race: String(race.id)
                                        )
                                    )
                                )
                            )
                        }
                    }
                }
            }.emptyContent(isEmpty: pastRaces.isEmpty){
               Text("No Past races")
                   .frame(maxHeight: .infinity, alignment: .center)
           }
        }
    }
}
