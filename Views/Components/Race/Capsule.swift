//
//  LiveCapsule.swift
//  testev2
//
//  Created by Henrique Pacheco on 10/04/2025.
//

import SwiftUI

struct LiveCapsule: View {
    
    var status: Status?

    var body: some View {
        ZStack {
            Circle().frame(width: 5, height: 20, alignment: .leading)
                .foregroundColor(status?.color ?? .clear)
                .padding(.trailing, 80)
        
            Text(status?.text ?? "")
                .foregroundColor(.primary)
                .font(.system(size: 12))
                .accessibilityLabel(Text("Status: \(status?.text ?? "")"))
            
            Capsule().fill(status?.color.opacity(0.1) ?? .clear)
                .stroke(status?.color ?? .clear, lineWidth: 1)
                .frame(width: 100, height: 25, alignment: .center).padding(.trailing, 10)
        }
    }
}

#Preview {
    LiveCapsule(status: .live)
}
