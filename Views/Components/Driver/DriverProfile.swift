//
//  DriverProfile.swift
//  F1 app
//
//  Created by Henrique Pacheco on 11/04/2025.
//

import SwiftUI

struct DriverProfile: View {
    
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                
                HStack {
                    Text("4")
                        .font(.system(size: 90, weight: .medium))
                        .foregroundColor(.orange.opacity(0.8))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 10)
            
                    AsyncImage(url: URL(string: "https://media.api-sports.io/formula-1/drivers/49.png")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200)
                            .clipped()
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.bottom, 20)
                            .mask(
                                LinearGradient(
                                    gradient: Gradient(stops: [
                                        .init(color: .black, location: 0),
                                        .init(color: .black, location: 0.6),
                                        .init(color: .clear, location: 1)
                                    ]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                    }
                    placeholder: {
                        ProgressView()
                    }
                }.frame(maxWidth: .infinity)
                 
              
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.primary.opacity(0.07))
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
                    
                    VStack{
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 15) {
                                Text("F1 2025")
                                    .font(.system(size: 24, weight: .semibold))
                                Text("Championship stats")
                                    .font(.subheadline)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            VStack {
                                Image("mclaren")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 40)
                                Text("Mclaren")
                                    .font(.system(size: 16, weight: .semibold))
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        HStack {
                            VStack(alignment: .center) {
                                Text("Position")
                                    .font(.system(size: 20))
                                    .foregroundStyle(.secondary)
                                Text("01")
                                    .font(.system(size: 60, weight: .bold))
                            }.frame(maxWidth: .infinity, alignment: .leading)
                            
                            VStack {
                                Text("Points")
                                    .font(.system(size: 20))
                                    .foregroundStyle(.secondary)
                                Text("63")
                                    .font(.system(size: 60, weight: .bold))
                            }.frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.leading, 40)
                        }
                        .padding(.top, 20)
                        
                        HStack {
                            VStack(alignment: .center) {
                                Text("Wins")
                                    .font(.system(size: 16))
                                    .foregroundStyle(.secondary)
                                Text("01")
                                    .font(.system(size: 40, weight: .bold))
                            }.frame(maxWidth: .infinity, alignment: .leading)
                            
                            VStack(alignment: .center) {
                                Text("Podiums")
                                    .font(.system(size: 16))
                                    .foregroundStyle(.secondary)
                                Text("12")
                                    .font(.system(size: 40, weight: .bold))
                            }.frame(maxWidth: .infinity, alignment: .center)
                            
                            VStack(alignment: .center) {
                                Text("Poles")
                                    .font(.system(size: 16))
                                    .foregroundStyle(.secondary)
                                Text("69")
                                    .font(.system(size: 40, weight: .bold))
                            }.frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        .padding(.top, 5)
                        
                        
                        Text("Since Debut")
                            .font(.system(size: 22, weight: .semibold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 10)
        
                        
                        HStack {
                            VStack(alignment: .center) {
                                Text("Wins")
                                    .font(.system(size: 16))
                                    .foregroundStyle(.secondary)
                                Text("05")
                                    .font(.system(size: 40, weight: .bold))
                            }.frame(maxWidth: .infinity, alignment: .leading)
                            
                            VStack(alignment: .center) {
                                Text("Podiums")
                                    .font(.system(size: 16))
                                    .foregroundStyle(.secondary)
                                Text("22")
                                    .font(.system(size: 40, weight: .bold))
                            }.frame(maxWidth: .infinity, alignment: .center)
                            
                            VStack(alignment: .center) {
                                Text("Poles")
                                    .font(.system(size: 16))
                                    .foregroundStyle(.secondary)
                                Text("250")
                                    .font(.system(size: 40, weight: .bold))
                            }.frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        .padding(.top, 5)
                        
                        VStack(alignment: .leading) {
                            Text("World Championships")
                                .font(.system(size: 25, weight: .semibold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, 10)
                            
                            Text("0")
                                .font(.system(size: 60, weight: .bold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                        }
                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding()
                }
                .frame(maxHeight: .infinity, alignment: .top)
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal,10)
            
        }.navigationTitle("Lando Norris")
            .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    DriverProfile()
      .padding()
}
