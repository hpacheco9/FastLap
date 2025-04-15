//
//  header.swift
//  testev2
//
//  Created by Henrique Pacheco on 07/04/2025.
//

import SwiftUI

struct Header: View {
    
    let title: String

    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
       HStack {
            Text(title)
               .font(Font.system(size: 20, weight: .semibold))
               .frame(maxWidth: .infinity, alignment: .leading)
               .foregroundStyle(.primary)
       
           
               Text("see all > ")
                    .foregroundStyle(.orange)
                    .font(Font.system(size: 18, weight: .medium))
           
        }
       .padding()
    }
}

#Preview {
    Header(title: "Upcoming")
}
