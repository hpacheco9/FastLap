//
//  PageViewmodel.swift
//  F1 app
//
//  Created by Henrique Pacheco on 11/04/2025.
//

import Foundation


class PageViewmodel {
    
    var model: PageModel
    
    lazy var title: String =  model.title
    
    lazy var image: String = model.image
    
    lazy var description: String = model.description
    
    init(model: PageModel) {
        self.model = model
    }
    
}


extension PageViewmodel: Identifiable {
    var id: String { UUID().uuidString }
}
