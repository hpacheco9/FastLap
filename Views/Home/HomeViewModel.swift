//
//  HomeViewModel.swift
//  F1 app
//
//  Created by Henrique Pacheco on 23/04/2025.
//

import Foundation
import NotificationCenter

@Observable
class HomeViewModel {
    
    enum State {
        case loading
        case loaded(DriverPageViewmodel?, SchedulePageViewmodel?)
        case empty
        case error
    }
    
    struct Dependencies {
        let service: any (HomeServiceProtocol & HomeServiceStoreProtocol)
        let notificationService: NotificationServiceProtocol
    }
    
    let headerUpcoming = LocalizationKey.Header.upcoming.localized
    let headerStandings = LocalizationKey.Header.standings.localized
    let title = LocalizationKey.Title.home.localized
    let buttonSeeAll = LocalizationKey.Button.seeall.localized
    
    
    private let dependencies: Dependencies
    var state: State = .loading
    var notificationsEnabled: Bool { dependencies.notificationService.isNotificationsEnabled   }
    
    init (dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    
    func requestNotificationPermission() {
        if notificationsEnabled {
           dependencies.notificationService.removeAllNotifications()
        } else {
            dependencies.notificationService.verifyNotificationPermission()
        }
    }

    
    @MainActor
    func loadData() async {
        do {
            async let rankings =  try await dependencies.service.fetchRankings()
            async let schedule =  try await dependencies.service.fetchSchedule()
            
            let (drivers, races) = try await (rankings, schedule)
            
            guard !races.response.isEmpty else {
                state = .empty
                return
            }
    
            let scheduleResponses = races.response.compactMap({ $0 })
            
            let isoFormatter: ISO8601DateFormatter = {
                let f = ISO8601DateFormatter()
                f.formatOptions = [.withInternetDateTime]
                return f
            }()
            
            let driversDataModel = try dependencies.service.insertRankings(drivers.response)
            let scheduleDataModel = try dependencies.service.insertSchedule(scheduleResponses)
            
            
            let upcomingRace = createScheduleModel(scheduleResponses: scheduleDataModel, now: Date(), isoFormatter: isoFormatter)
            let driver = createDriverModel(drivers: driversDataModel)
            
            
            state = .loaded(driver, upcomingRace)
        }
        catch {
            do {
                
                let isoFormatter: ISO8601DateFormatter = {
                    let f = ISO8601DateFormatter()
                    f.formatOptions = [.withInternetDateTime]
                    return f
                }()
                
                let drivers = try dependencies.service.fetchStandings()
                let driver = createDriverModel(drivers: drivers)
                
                let races = try dependencies.service.fetchScheduleData()
                let race = createScheduleModel(scheduleResponses: races, now: Date(), isoFormatter: isoFormatter)
                
                state = .loaded(driver, race)
                
            } catch {
                state = .error
            }
        }
        
        func createDriverModel(drivers: [StandingDataModel]) -> DriverPageViewmodel? {
            guard let response = drivers.first else {
                return nil
            }
            
            let model = DriverPageViewmodel(model:  DriverModel(
                position: response.position,
                driver: DriverModel.Driver(
                    id: response.driver.id,
                    name: response.driver.name,
                    number: response.driver.number,
                    abbreviation: response.driver.abbreviation,
                    imageUrl: response.driver.imageUrl
                ),
                team: DriverModel.Team(
                    id: response.team.id,
                    name: response.team.name,
                    logo: response.team.assetForTeamId(response.team.id).0,
                    color: response.team.assetForTeamId(response.team.id).1
                ),
                points: response.points ?? 0,
                wins: response.wins,
                behind: response.behind,
                season: response.season
            ))
            return model
        }
        
        func createScheduleModel(scheduleResponses: [ScheduleDataModel], now: Date, isoFormatter: ISO8601DateFormatter) -> SchedulePageViewmodel? {
            let nextRace = scheduleResponses.compactMap({ race -> (Date, ScheduleDataModel)? in
                guard let ds = race.date,
                      let date = isoFormatter.date(from: ds),
                      date >= now.addingTimeInterval(-3600) 
                else { return nil }
                return (date, race)
            }).min(by: { $0.0 < $1.0 })?.1

            
            if let nextRace = nextRace,
               let ds = nextRace.date,
               let raceDate = isoFormatter.date(from: ds) {

                let calendar = Calendar.current
                let day = String(calendar.component(.day, from: raceDate))
                let month = calendar.component(.month, from: raceDate).montNameMonth()
                let year = calendar.component(.year, from: raceDate)
                let hour = calendar.component(.hour, from: raceDate)
                let minute = calendar.component(.minute, from: raceDate)

                let upcomingRace = SchedulePageViewmodel(model: ScheduleModel(
                    id: nextRace.id,
                    competition: ScheduleModel.Competition(
                        id: nextRace.competition.id,
                        name: nextRace.competition.name,
                        location: ScheduleModel.Competition.Location(
                            country: nextRace.competition.location.country,
                            city: nextRace.competition.location.city
                        )
                    ),
                    circuit: ScheduleModel.Circuit(
                        id: nextRace.circuit.id,
                        name: nextRace.circuit.name,
                        image: nextRace.circuit.assetForCircuitId(nextRace.circuit.id)
                    ),
                    type: nextRace.type.abreviation,
                    day: day,
                    month: month,
                    year: String(String(year).suffix(2)),
                    time: "\(hour):\(String(minute).addZero)",
                    timezone: nextRace.timezone,
                    status: nextRace.status
                ))
                
                let date = "\(upcomingRace.day)/\(upcomingRace.month)/\(upcomingRace.year) \(upcomingRace.time)"
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yy HH:mm"
                formatter.timeZone = TimeZone.current
                let notification = Notification(id: upcomingRace.id, title: "Grand Prix of \(upcomingRace.country)", subtitle: "The \(upcomingRace.type) is about to start", date: formatter.date(from: date))
                
                dependencies.notificationService.scheduleNotification(data: notification)
                
         
                return upcomingRace
            }
            return nil
        }
    }
}
    
