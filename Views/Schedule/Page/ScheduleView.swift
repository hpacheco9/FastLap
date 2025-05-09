//
//  Schedule.swift
//  testev2
//
//  Created by Henrique Pacheco on 07/04/2025.
//

import SwiftUI

struct Schedule: View {
    
    var viewmodel: ScheduleViewModel

    @State private var type: ScheduleViewModel.ScheduleTypes = .upcoming
    
    init(viewmodel: ScheduleViewModel) {
        UISegmentedControl.appearance().selectedSegmentTintColor = .orange
        self.viewmodel = viewmodel
    }
    
    var body: some View {
        VStack {
            switch viewmodel.state {
                case .loading:
                    ProgressView()
                case .loaded(let pasRaces, let upcomingRaces ):
                     VStack {
                         Picker("Type", selection: $type) {
                             ForEach(ScheduleViewModel.ScheduleTypes.allCases, id: \.self){
                                Text($0.rawValue)
                            }
                      }
                        .pickerStyle(.segmented)
                        .padding()
                         
                         ScheduleView(scheduleTypes: type, pastRaces: pasRaces, upcomingRaces: upcomingRaces)    
                }
            case .empty:
                 EmptyView()
            case .error:
                Text("Error")
            }
        }
        .navigationTitle("Schedule")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            Task {
                await viewmodel.loadData()
            }
        }
    }
}


#Preview {
    Schedule(viewmodel: ScheduleViewModel(
        dependencies: .init(
            service: ScheduleService(client: APIClient(session: URLSession(configuration: .default))))))
}
