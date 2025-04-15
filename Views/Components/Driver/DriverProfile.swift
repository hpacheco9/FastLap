//
//  DriverProfile.swift
//  F1 app
//
//  Created by Henrique Pacheco on 11/04/2025.
//

import SwiftUI

struct DriverProfile: View {
    
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https://media.api-sports.io/formula-1/drivers/49.png")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250)
                    .clipped()
                    .padding(.trailing, 30)
                    .padding(.bottom, 20)
            } placeholder: {
                ProgressView()
            }.frame(maxHeight: .infinity ,alignment: .top)
        }
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    DriverProfile()
}
