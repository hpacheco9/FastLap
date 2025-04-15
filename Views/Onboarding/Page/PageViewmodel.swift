//
//  PageViewmodel.swift
//  F1 app
//
//  Created by Henrique Pacheco on 11/04/2025.
//

import Foundation


struct PageViewmodel {
    
    var model: PageModel
    
    var title: String { model.title }
    
    var image: String { model.image }
    
    var description: String { model.description }
    
    init(model: PageModel) {
        self.model = model
    }
    
}


extension PageViewmodel: Identifiable {
    var id: String { UUID().uuidString }
}
