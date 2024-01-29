//
//  ProgressLoader.swift
//  MiamIOSFramework
//
//  Created by Miam on 21/06/2022.
//

import SwiftUI

@available(iOS 14, *)
public struct ProgressLoader: View {

    @State private var isAnimating = false
    @State private var showProgress = false
    private var color: Color

    var foreverAnimation: Animation {
        Animation.linear(duration: 0.5)
            .repeatForever(autoreverses: false)
    }

    public init(color: Color) {
        self.color = color
    }

    public var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 8.0)
                .opacity(0.3)
                .foregroundColor(color)

            Circle()
                .trim(from: 0, to: 0.3)
                .stroke(style: StrokeStyle(lineWidth: 8.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(color)
                .rotationEffect(.degrees(isAnimating ? 360 : 0))
                .onAppear {
                    DispatchQueue.main.async {
                        withAnimation(foreverAnimation) {
                            isAnimating = true
                        }
                    }
                }
        }.frame(width: 60, height: 60)
    }
}
