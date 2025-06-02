//
//  NoSchedule.swift
//  F1 app
//
//  Created by Henrique Pacheco on 22/05/2025.
//

import SwiftUI

struct NoSchedule: View {
    
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.primary.opacity(0.1))
                .overlay(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            colorScheme == .dark ? .secondary.opacity(0.01) : .white.opacity(0.5),
                            .clear
                        ]),
                        startPoint: colorScheme == .dark ? .bottom : .top,
                        endPoint: colorScheme == .dark ? .top : .bottom
                    )
                )
            
            Text("No Upcoming Race")
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.primary)
        }.padding(10)
        .frame(height: 280)
        
        
    }
}

#Preview {
    NoSchedule()
}
