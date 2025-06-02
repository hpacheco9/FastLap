//
//  SkeletonView.swift
//  F1 app
//
//  Created by Henrique Pacheco on 21/05/2025.
//

import SwiftUI

struct SkeletonView<S: Shape> : View {
    var shape: S
    var color: Color
    init(_ shape: S, _ color: Color = .gray.opacity(0.3)) {
        self.shape = shape
        self.color = color
    }
    
    @State private var isAnimating: Bool = false
    var body: some View {
        shape.fill(color)
            .overlay {
                GeometryReader {
                    let size = $0.size
                    let width = size.width / 2
                    let blurRadius = max(width / 2, 30)
                    let blurDiameter = blurRadius * 2
                    let minX = -(width + blurDiameter)
                    let maxX = size.width + width + blurDiameter
                    
                    
                    Rectangle()
                        .fill(.gray)
                        .frame(width: width, height: size.height * 2)
                        .frame(height: size.height)
                        .blur(radius: blurRadius)
                        .rotationEffect(.init(degrees: 5))
                        .blendMode(.softLight)
                        .offset( x: isAnimating ? maxX : minX )
                }
             
            }
            .clipShape(shape)
            .compositingGroup()
            .onAppear {
                guard !isAnimating else { return }
                withAnimation(animation) {
                    isAnimating = true
                }
            }.onDisappear {
                isAnimating = false
            }
    }
    
    var animation: Animation {
        .easeInOut(duration: 1.5).repeatForever(autoreverses: false)
    }


}

#Preview {
    SkeletonView(.circle).frame(width: 100, height: 100)
}
