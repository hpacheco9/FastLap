//
//  SwiftUIView.swift
//  F1 app
//
//  Created by Henrique Pacheco on 21/05/2025.
//

import SwiftUI


struct EmptyCard: View {
    
    
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
                
                
                HStack {
                    SkeletonView(.circle)
                        .frame(height: 70)
                        
                    
                    VStack(alignment: .leading) {
                        
                        SkeletonView(.capsule)
                            .frame(width: 100, height: 10)
                        
                        SkeletonView(.capsule)
                            .frame(width: 200, height: 10)
                    }.padding(.leading, 20)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding(.top, 20)
                    .padding(.leading, 10)
                
                HStack {
                    VStack {
                        SkeletonView(.capsule)
                            .frame(width: 70, height: 10)
                        
                        SkeletonView(.capsule)
                            .frame(width: 20, height: 10)
                            
                    }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                        .padding(.bottom, 20)
                        .padding(.leading, 20)
                    
                    VStack {
                        SkeletonView(.capsule)
                            .frame(width: 70, height: 10)
                        
                        SkeletonView(.capsule)
                            .frame(width: 20, height: 10)
                            
                    }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                        .padding(.bottom, 20)
                        .padding(.trailing, 150)
                }

            }.padding(10)
            .frame(height: 300)
            
       
    }
}

#Preview {
    EmptyCard()
        .frame(height: 300)
}
