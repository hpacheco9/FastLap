//
//  ResultsHeader.swift
//  F1 app
//
//  Created by Henrique Pacheco on 26/05/2025.
//

import SwiftUI

struct ResultsHeader: View {
    
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 10)
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
            
            HStack {
                Text("Pos")
                    .padding(.leading)
                    .font(.system(size: 18, weight: .medium))
                    .frame(maxWidth: 50, alignment: .leading)
                    .padding(.leading, 2)
                    .accessibilityLabel(LocalizationKey.accessbilty.pos.localized)
                
                Text("Name")
                    .font(.system(size: 18, weight: .medium))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 30)
                    
                
                Text("Time")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(alignment: .leading)
                    .padding(.leading)
                    .font(.system(size: 18, weight: .medium))
                    
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        
        }
        .frame(height: 50)
        .padding(.horizontal)
        .padding(.top, 10)
    }
}

#Preview {
    ResultsHeader()
}
