//
//  EmptyHomeView.swift
//  F1 app
//
//  Created by Henrique Pacheco on 29/05/2025.
//

import SwiftUI

struct EmptyHomeView: View {
    var body: some View {
        EmptyHeader()
            .padding(.horizontal, 5)
        EmptyCard()
            .padding(.vertical, -15)
        EmptyHeader()
            .padding(.horizontal, 5)
        EmptyCard()
            .padding(.vertical, -15)
    }
}

#Preview {
    EmptyHomeView()
}
