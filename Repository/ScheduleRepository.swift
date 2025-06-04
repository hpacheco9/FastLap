//
//  ScheduleRepository.swift
//  F1 app
//
//  Created by Henrique Pacheco on 02/06/2025.
//

import Foundation
import SwiftData



class ScheduleRepository {
    
    var modelContext: ModelContext
    var schedule = [ScheduleDataModel]()
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func addStandings(_ newStandings: [ScheduleAPIModel.Response]) async throws {
        for standingsResponse in newStandings {
           

           
          

          /*  modelContext.insert(driver)
            modelContext.insert(team)
            modelContext.insert(standings)*/

        }
    }
    
    func fetchStandings() -> [ScheduleDataModel]{
        do {
            let descriptor = FetchDescriptor<ScheduleDataModel>()
            schedule = try modelContext.fetch(descriptor)
            return schedule
        }
        catch {
            return []
        }
    }
   
    


}
