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
        PageViewmodel(model: .init(image: "image 1", title: "fig.title".localized, description: "onboard1.description".localized)),
        PageViewmodel(model: .init(image: "image 2", title: "onboard2.title".localized, description: "onboard2.description".localized)),
        PageViewmodel(model: .init(image: "image 3", title: "onboard3.title".localized, description: "onboard3.description".localized)),
    ]
    
    func onAppear(index: Int) {
        currentPage = index
    }
    
    func isLastPage() -> Bool {
        currentPage == Pages.count - 1
    }
}





