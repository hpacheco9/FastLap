//
//  CardRace .swift
//  testev2
//
//  Created by Henrique Pacheco on 07/04/2025.
//

import SwiftUI

struct CardRace_: View {
    
    let Race: String
    let GP: String
    let Day: String
    let Time: String
    let Month: String
    let Number: Int
    let type: String
    let image: String
    let flag: String
    let action: () -> Void
    let Status : Status
    
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
            
            VStack {
                Button (action: action){
                    Label("",systemImage: "chevron.right")
                }
                .foregroundColor(.primary)
                .font(.system(size: 20, weight: .bold))
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing, 10)
            .padding(.bottom, 220)
            
            // header
            VStack (alignment: .leading) {
                HStack{
                    Image(flag)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 15)
                        
                    
                    VStack {
                        Text(GP)
                            .foregroundStyle(.primary)
                            .font(.system(size: 16, weight: .semibold))
                    }
                }.frame(alignment: .top)
                
                Text(Race)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.primary)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(.leading, 20)
            .padding(.top, 20)
            .padding(.bottom, 200)
            
                HStack {
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .shadow(color: .orange.opacity(1), radius: 0, x: 2, y: 6)
                        .frame(maxWidth: 190, maxHeight: 220, alignment: .leading)
                        .padding(.leading, 10)
                        
                    Text("\(Number)")
                        .font(.system(size: 120, weight: .medium))
                        .foregroundColor(.orange.opacity(0.8))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 10)
                }
                .frame(maxWidth: .infinity, maxHeight: 200, alignment: .leading)
                .padding(.bottom, 10)
            
            HStack {
                Rectangle().fill(Color.orange).frame(width: 2, height: 50, alignment: .center).padding(.leading, 15.5)
                
                VStack() {
                    Text("\(Day)")
                        .font(.system(size: 40, weight: .medium))
                        .foregroundColor(.orange)
                    
                    Text("\(Month)")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.gray)
                        .padding(.bottom, 5)
                
                }
                Circle().fill(Color.primary).frame(width: 5, height: 5, alignment: .center).padding(.trailing, 2)
                    .padding(.leading, 2)
                
                
                VStack {
                    Text("\(type)")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.primary)
                        .padding(.bottom, 2)
                    
                    Text("\(Time)")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.gray)
                        
                }.padding(.trailing, 20)
                
                
                LiveCapsule(status: .soon)
               
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                .padding(.bottom, 10)
                
            

        }
        .frame(maxWidth: .infinity, maxHeight: 250)
        .padding(3)
    
    }
}


#Preview {
    CardRace_(Race: "Circuit de Barcelona-Catalunya", GP: "GP Japan", Day: "06", Time:"9.30 AM", Month: "April 25'", Number: 25, type: "FP2", image: "Barca", flag: "JP", action: {}, Status: .soon)
}
