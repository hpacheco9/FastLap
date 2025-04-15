//
//  Standings.swift
//  testev2
//
//  Created by Henrique Pacheco on 07/04/2025.
//

import SwiftUI

struct Standings: View {
    
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .orange
        
    }
    
    @State private var type: StandingTypes = .drivers
    
    var body: some View {
      
        
            VStack {
                Picker("Type", selection: $type) {
                    ForEach(StandingTypes.allCases, id: \.self){
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                
                StandingsView(standingsType: type)
            }
            .frame(alignment: .top)
            .navigationTitle("Standings")
            .toolbarTitleDisplayMode(.inline)
    }
}


#Preview {
    Standings()
}
