//
//  ConditionalModifier.swift
//  F1 app
//
//  Created by Henrique Pacheco on 27/05/2025.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder
    func emptyContent<FallbackView: View>(isEmpty: Bool,@ViewBuilder fallbackView: () -> FallbackView) -> some View {
        if isEmpty {
            fallbackView()
        } else {
            self
        }
    }
}
