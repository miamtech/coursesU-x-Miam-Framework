//
//  MiamBudgetPlannerStickyFooter.swift
//  MiamIOSFramework
//
//  Created by didi on 5/23/23.
//  Copyright © 2023 Miam. All rights reserved.
//

import mealzcore
import MealziOSSDK
import SwiftUI

public class MealPlannerSingleton {
    public static var budget: Double = 0
}

@available(iOS 14, *)
struct ChatBubbleShape: Shape {
    var cornerRadius: CGFloat = 4
    var triangleHeight: CGFloat = 5
    var triangleWidth: CGFloat = 10
    var triangleOffset: CGFloat = 1.4

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let bubbleRect = rect.insetBy(dx: 0, dy: triangleHeight)

        path.addRoundedRect(in: bubbleRect, cornerSize: CGSize(width: cornerRadius, height: cornerRadius))

        let triangleRect = CGRect(x: rect.midX - triangleWidth / 2,
                                  y: rect.maxY - triangleHeight,
                                  width: triangleWidth,
                                  height: triangleHeight)
        path.move(to: CGPoint(x: triangleRect.midX * triangleOffset, y: triangleRect.maxY))
        path.addLine(to: CGPoint(x: triangleRect.minX * triangleOffset, y: triangleRect.minY))
        path.addLine(to: CGPoint(x: triangleRect.maxX * triangleOffset, y: triangleRect.minY))

        return path
    }
}
