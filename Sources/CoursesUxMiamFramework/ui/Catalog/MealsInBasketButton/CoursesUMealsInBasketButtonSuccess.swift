//
//  CoursesUMealsInBasketButtonSuccess.swift
//
//
//  Created by miam x didi on 22/02/2024.
//

import mealzcore
import MealziOSSDK
import SwiftUI

@available(iOS 14, *)
public struct CoursesUMealsInBasketButtonSuccess: MealsInBasketButtonSuccessProtocol {
    public init() {}
    public func content(params: MealsInBasketButtonSuccessParameters) -> some View {
        Button(action: params.onNavigateToMyMeals, label:{
            HStack {
                Image.mealzIcon(icon: .cutlery)
                    .renderingMode(.template)
                // .foregroundColor(Color.mealzColor(.standardLightText))
                Text(Localization.myMeals.mealsAdded(numberOfMeals: Int32(params.mealsCount)).localised)
                    // .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodyBigBoldStyle)
                    .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.bodyBigBoldStyleMulish)
                // .foregroundColor(Color.mealzColor(.standardLightText))
                Image.mealzIcon(icon: .arrow)
                    .renderingMode(.template)
                // .foregroundColor(Color.mealzColor(.standardLightText))
            }
            .foregroundColor(Color.mealzColor(.standardLightText))
            .padding(Dimension.sharedInstance.lPadding)
        })
        .background(Color.mealzColor(.primary))
        .clipShape(Capsule())
        .padding(Dimension.sharedInstance.lPadding)
    }
}
