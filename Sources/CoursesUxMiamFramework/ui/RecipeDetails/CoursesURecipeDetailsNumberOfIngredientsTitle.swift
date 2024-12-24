//
//  CoursesURecipeDetailsNumberOfIngredientsTitle.swift
//  CoursesUxMiamFramework
//
//  Created by Damien Walerowicz on 12/03/2024.
//

import Foundation

import mealzcore
import MealziOSSDK
import SwiftUI

@available(iOS 14, *)
public struct CoursesUNumberOfIngredientsTitle: BaseTitleProtocol {
    public init() {}
    public func content(params: TitleParameters) -> some View {
        HStack {
            Text(params.title)
                .foregroundColor(Color.mealzColor(.primaryText))
                .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.titleStyle)
                .padding()
            if let subtitle = params.subtitle {
                MealzProductBase.unavailableTag(text: subtitle)
            }
            Spacer()
        }.frame(maxWidth: .infinity)
    }
}
