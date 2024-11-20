//
//  CoursesUBackgroundView.swift
//
//
//  Created by Diarmuid McGonagle on 25/01/2024.
//

import Foundation
import mealzcore
import MealziOSSDK
import SwiftUI

@available(iOS 14, *)
public struct CoursesUBackgroundView: BackgroundProtocol {
    public init() {}
    public func content(params: BaseBackgroundParameters) -> some View {
        ZStack(alignment: .top) {
            Color.budgetBackgroundColor
            Image(packageResource: "WhiteWave", ofType: "png")
                .resizable()
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.2)
        }
    }
}

