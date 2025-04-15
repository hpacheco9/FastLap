//
//  Schedule.swift
//  testev2
//
//  Created by Henrique Pacheco on 07/04/2025.
//

import SwiftUI

struct Schedule: View {
    
    @State private var favoriteColor = 0
    
    @State private var type: ScheduleTypes = .upcoming
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .orange
        
    }
    
    var body: some View {
        
        VStack {
            Picker("Type", selection: $type) {
                ForEach(ScheduleTypes.allCases, id: \.self){
                    Text($0.rawValue)
                }
          }
            .pickerStyle(.segmented)
            .padding()
            
            
            ScheduleView(scheduleTypes: type)

        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Schedule")
        .navigationBarTitleDisplayMode(.inline)
         
    }
        
}

#Preview {
    Schedule()
}
