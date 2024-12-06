//
//  CoursesUMyMealEmptyView.swift
//  MiamIOSFramework
//
//  Created by Miam on 21/07/2022.
//

import SwiftUI
import mealzcore
import MealziOSSDK

@available(iOS 14, *)

@available(iOS 14, *)
public struct CoursesUMyMealEmptyView: EmptyProtocol {
    public init() {}
    public func content(params: BaseEmptyParameters) -> some View {
        VStack(spacing: Dimension.sharedInstance.lPadding) {
            Image(packageResource: "SearchWithCartonIconColor", ofType: "png")
                .resizable()
                .frame(width: 140, height: 140)
            Text(Localization.myMeals.noMealIdeaInBasket.localised)
                .foregroundColor(Color.mealzColor(.standardDarkText))
                .coursesUFontStyle(
                    style: CoursesUFontStyleProvider.sharedInstance.titleMediumStyle
                )
                .multilineTextAlignment(.center)
                .padding()
            if let cta = params.onOptionalCallback, let buttonText = params.buttonText {
                Button(
                    action: cta,
                    label: {
                        Text(buttonText)
                            .miamFontStyle(
                                style: MiamFontStyleProvider.sharedInstance.bodyBigBoldStyle
                            )
                            .foregroundColor(Color.mealzColor(.standardLightText))
                    })
                .padding(Dimension.sharedInstance.lPadding)
                .background(Color.mealzColor(.primary))
                .clipShape(Capsule())
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.mealzColor(.white))
    }
}
