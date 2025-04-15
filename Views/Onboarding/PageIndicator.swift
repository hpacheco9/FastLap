//
//  PageIndicator.swift
//  testev2
//
//  Created by Henrique Pacheco on 10/04/2025.
//

import SwiftUI

struct PageIndicator: View {
    
    
    var totalPages: Int
    
    @Binding var currentPage: Int
    
    var body: some View {
        HStack {
            ForEach(0 ..< totalPages, id: \.self) { page in
                Capsule().fill(.primary).frame(width: currentPage == page ? 40 : 10 , height: 5)
            }
        }
    }
}

#Preview {
    
    @Previewable @State var currentPage: Int = 2
    PageIndicator(totalPages: 3, currentPage: $currentPage)
}
