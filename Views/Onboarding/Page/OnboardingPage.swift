//
//  OnboardingPage.swift
//  testev2
//
//  Created by Henrique Pacheco on 10/04/2025.
//

import SwiftUI

struct OnboardingPage: View {
    
    var dataModel: PageViewmodel
    
    
    @Environment(\.colorScheme) var colorScheme
   
    var body: some View {
        ZStack {
            VStack {
                Image(dataModel.image)
                    .resizable()
                    .clipped()
                    .frame(maxWidth: .infinity, maxHeight: 300, alignment: .topTrailing)
                    .overlay(
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: colorScheme == .dark ? .black.opacity(1) : .white.opacity(1), location: 0.4),
                                .init(color: colorScheme == .dark ? .black.opacity(0.90) : .white.opacity(0.90), location: 0.6),
                                .init(color: colorScheme == .dark ? .black.opacity(0.80) : .white.opacity(0.80), location: 0.7),
                                .init(color: colorScheme == .dark ? .black.opacity(0.70) : .white.opacity(0.70), location: 0.8),

                                .init(color: colorScheme == .dark ? .black.opacity(0.5) : .white.opacity(0.5), location: 1.0)
                            ]),
                            startPoint: .bottomLeading,
                            endPoint: .topTrailing
                        )
                    )
                
                VStack(alignment: .leading) {
                    Text(dataModel.title)
                        .font(.system(size: 50, weight: .bold, design: .default))
                        .foregroundStyle(.primary)
                    
                    Text(dataModel.description)
                        .font(.system(size: 22, weight: .medium, design: .default))
                        .foregroundStyle(.primary)
                        .padding(.top)
                        
                }
                
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(.leading, 20)
                .padding(.top, 50)
            }
        
        }
        .ignoresSafeArea(.all)

    }
}




#Preview {
    


}
