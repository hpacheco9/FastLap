//
//  DriversColletion.swift
//  testev2
//
//  Created by Henrique Pacheco on 07/04/2025.
//

import SwiftUI

struct DriversColletion: View {
    
    @EnvironmentObject var coordinator: Coordinator
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(1..<21) { index in
                    CardDriver(number: "\(index)", action: {}, first: "Lewis", last: "Hamilton", image: "ham", equipa: "ferrari")
                        .padding(.vertical, 20)
                    
                }
            }
        }
    }
}

#Preview {
    DriversColletion()
}
