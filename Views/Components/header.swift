//
//  header.swift
//  testev2
//
//  Created by Henrique Pacheco on 07/04/2025.
//

import SwiftUI

struct Header: View {
    
    let title: String
    let buttonTitle: String
    let action: () -> Void

    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
       HStack {
            Text(title)
               .font(Font.system(size: 20, weight: .semibold))
               .frame(maxWidth: .infinity, alignment: .leading)
               .foregroundStyle(.primary)
               .accessibilityAddTraits(.isHeader)
               
           Button(buttonTitle){
               action()
           }
            .foregroundStyle(.orange)
            .font(Font.system(size: 18, weight: .medium))
            .accessibilityLabel(buttonTitle + "button")
                    
           
        }
       .padding()
    }
}

#Preview {
    Header(title: "Upcoming", buttonTitle: "see all>", action: {print("action")})
}
