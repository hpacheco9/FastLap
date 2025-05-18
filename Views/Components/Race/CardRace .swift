//
//  CardRace .swift
//  testev2
//
//  Created by Henrique Pacheco on 07/04/2025.
//

import SwiftUI

struct CardRace_: View {
    
    let schedule: SchedulePageViewmodel
    let status: Status
    
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
                Label("", systemImage: "chevron.right")
                        .foregroundColor(.primary)
                        .font(.system(size: 20, weight: .bold))
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing, 10)
            .padding(.bottom, 210)
            
            // header
            VStack(alignment: .leading) {
                HStack {
                    Image(schedule.country)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 15)
                    
                    VStack {
                        Text("GP " + schedule.country)
                            .foregroundStyle(.primary)
                            .font(.system(size: 16, weight: .semibold))
                    }
                }
                .frame(alignment: .top)
                .padding(.bottom, 5)
                
                Text(schedule.circuitName)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.primary)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(.leading, 20)
            .padding(.top, 25)
            .padding(.bottom, 200)
            
            HStack {
                Image(schedule.circuitImage)
                    .resizable()
                    .scaledToFit()
                    .shadow(color: .orange.opacity(1), radius: 0, x: 2, y: 6)
                    .frame(maxWidth: 150, maxHeight: 170, alignment: .leading)
                    .padding(.leading, 10)
                
                Text("\(schedule.circuitId)".addZero())
                    .font(.system(size: 120, weight: .medium))
                    .foregroundColor(.orange.opacity(0.8))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, 10)
            }
            .frame(maxWidth: .infinity, maxHeight: 200, alignment: .leading)
            .padding(.bottom, 10)
            
            HStack {
                Rectangle().fill(Color.orange).frame(width: 2, height: 50, alignment: .center).padding(.leading, 15.5)
                
                VStack(alignment: .leading){
                    Text(schedule.day.addZero())
                        .font(.system(size: 40, weight: .medium))
                        .foregroundColor(.orange)
                    
                    Text(schedule.month)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.gray)
                        .padding(.bottom, 5)
                    
                }
                Circle().fill(Color.primary).frame(width: 5, height: 5, alignment: .center).padding(.trailing, 2)
                    .padding(.leading, 2)
                
                
                VStack {
                    Text("\(schedule.type)".getType())
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.primary)
                        .padding(.bottom, 2)
                    
                    Text(schedule.time)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.gray)
                    
                }.padding(.trailing, 20)
                
                LiveCapsule(status: status)
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                .padding(.bottom, 10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    
    let scheduleModel = ScheduleModel(
        id: 1671,
        competition: ScheduleModel.Competition(
            id: 2,
            name: "Bahrain Grand Prix",
            location: ScheduleModel.Competition.Location(
                country: "Bahrain",
                city: "Sakhir"
            )
        ),
        circuit: ScheduleModel.Circuit(
            id: 2,
            name: "Bahrain International Circuit",
            image: "ChinaGP"
        ),
        type: "Race",
        day: "06",
        month: "April 25",
        time: "9:00 AM",
        timezone: "utc",
        status: "Completed"
    )
    
    let model = SchedulePageViewmodel(model: scheduleModel)
    
    CardRace_(schedule: model, status: .soon)
}
