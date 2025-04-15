//
//  OnboardViewModel.swift
//  testev2
//
//  Created by Henrique Pacheco on 10/04/2025.
//

import Combine

protocol OnboardRepresentable {
    var image: String { get }
    var title: String { get }
    var description: String { get }
}

class OnboardViewModel: ObservableObject {
    
    @Published var currentPage: Int = 0
    
    let Pages: [PageViewmodel] = [
        PageViewmodel(model: .init(image: "image 1", title: "fig.title".localized, description: "Explore detailed stats for all drivers and teams.")),
        PageViewmodel(model: .init(image: "image 2", title: "onboard2.title".localized, description: "Never miss a race with our interactivecalendar.")),
        PageViewmodel(model: .init(image: "image 3", title: "onboard3.title".localized, description: "Get notified for qualifying results, race start times, and major updates.")),
    ]
    
    func onAppear(index: Int) {
        currentPage = index
    }
    
    func isLastPage() -> Bool {
        currentPage == Pages.count - 1
    }
}





