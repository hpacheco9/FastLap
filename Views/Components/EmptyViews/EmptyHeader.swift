//
//  EmptyHeader.swift
//  F1 app
//
//  Created by Henrique Pacheco on 21/05/2025.
//

import SwiftUI

struct EmptyHeader: View {
    var body: some View {
        HStack {
            SkeletonView(.capsule)
                .frame(width: 150, height: 15,alignment: .leading)
                .frame(maxWidth: .infinity, alignment: .leading)
        
            
            SkeletonView(.capsule)
                .frame(width: 80, height: 15,alignment: .trailing)
            
         }
        .frame(maxWidth: .infinity)
        .padding()
        
    }
}

#Preview {
    EmptyHeader()
}
