//
//  Coordinator.swift
//  testev2
//
//  Created by Henrique Pacheco on 08/04/2025.
//

import SwiftUI
import SwiftData

enum Page: Identifiable, Hashable, Equatable {
    
    static func == (lhs: Page, rhs: Page) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    case home(viewmodel: HomeViewModel), standings(viewmodel: StandingsViewModel), shcedule(viewmodel: ScheduleViewModel)

    var id : String {
        switch self {
        case .home:
            "/home"
        case .standings:
            "/standings"
        case .shcedule:
            "/schedule"
        }
    }
}

enum Sheet: Identifiable, Hashable, Equatable {
    
    static func == (lhs: Sheet, rhs: Sheet) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    case driverprofile(viewModel: DriverStatsViewmodel), teamprofile(viewmodel: TeamStatsViewmodel) ,results(viewModel: RaceStandingsViewmodel)
    
    var id : String {
        switch self {
        case .driverprofile:
            "/driverprofile"
        case .teamprofile:
            "/teamprofile"
        case .results:
            "/results"
        }
    }
}



class Coordinator: ObservableObject {
    
    @Published var path = NavigationPath()
    @Published var sheet: Sheet?
    @Environment(\.modelContext) private var modelContext
    
   lazy var schedule: ScheduleViewModel =  ScheduleViewModel(
            dependencies: .init(
                service: ScheduleService(client: APIClient(session: URLSession(configuration: .default)),
                         scheduleRepository: ScheduleRepository(modelContext: modelContext))
            )
        )
    
   lazy var home = HomeViewModel(
        dependencies: .init(
            service: Homeservice(client: APIClient(session: URLSession(configuration: .default)),
                                 homeRepository: HomeRepository(standingsRepsitory: DriverStandingsRepository(modelContext: modelContext), scheduleRepository: ScheduleRepository(modelContext: modelContext))), notificationService: NotificationService(notification: UNUserNotificationCenter.current())
        )
    )
    
   lazy var standings = StandingsViewModel(
    dependencies: .init(
                  service: StandingsService(
                      client: APIClient(session: URLSession(configuration: .default)),
                      standingsREpository: StandingsRepository(
                          driverRepository: DriverStandingsRepository(modelContext: modelContext),
                          teamStandings: TeamStandingsRepository(modelContext: modelContext)
                      )
                  )
              )
)
    
   lazy var driver: DriverStatsViewmodel = DriverStatsViewmodel(
        dependencies:
                .init(
                    service: DriverStatsService(client: APIClient(session: URLSession(configuration: .default))), driver: nil
            )
        )
    
    
   lazy var team: TeamStatsViewmodel = TeamStatsViewmodel(
        dependencies:
                .init(
                    service: TeamStatsService(client: APIClient(session: URLSession(configuration: .default))), team: nil
            )
        )
    
   lazy var results: RaceStandingsViewmodel =   RaceStandingsViewmodel(
        dependencies: .init(
            service: RaceRankingsService(client: APIClient(session: URLSession(configuration: .default))), race: "1671"
        )
     )
        
    
    func push(page: Page) {
        path.append(page)
    }
    
    func present(sheet: Sheet) {
        self.sheet = sheet
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    @ViewBuilder
    func build(page: Page) -> some View {
        switch page {
        case let  .home(viewmodel):
            
            Home(
                viewModel: viewmodel
            )
            
        case let .standings(viewmodel):
            
            Standings(
                viewModel: viewmodel
            )
            
        case let .shcedule(viewmodel):
            
            Schedule(
                viewmodel: viewmodel
            )
        }
    }
    
    @ViewBuilder
    func build(sheet: Sheet) -> some View {
        switch sheet {
        case let .driverprofile(viewmodel):
            NavigationStack {
                DriverProfile( viewmodel : viewmodel)
                
            }
        case let .teamprofile(viewmodel):
            NavigationStack {
                TeamStatsView(viewmodel: viewmodel)
            }
        case let .results(viewmodel):
            NavigationStack {
                RaceStandingsPage(viewmodel: viewmodel)
            }
        }
    }
}
