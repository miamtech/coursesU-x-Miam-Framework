//
//  SwiftUIView.swift
//
//
//  Created by didi on 6/13/23.
//

import miamCore
import MiamIOSFramework
import SwiftUI

@available(iOS 14, *)
public struct CoursesUMealPlannerRecapView: MealPlannerRecapProtocol {
    var showPromotions: () -> Void

    public init(showPromotions: @escaping () -> Void) {
        self.showPromotions = showPromotions
    }

    let dimension = Dimension.sharedInstance
    public func content(params: MealPlannerRecapViewParameters) -> some View { ZStack(alignment: .top) {
        Color.budgetBackgroundColor
        CoursesUTwoMealsBackground()
        VStack(spacing: -40.0) {
            MealPlannerBackground()
            VStack(spacing: 25) {
                Image(packageResource: "GreenCheckmarkIcon", ofType: "png")
                    .resizable()
                    .frame(width: 30, height: 30)
                Text(Localization.myBudget.mealPlannerFinalize.localised)
                    .multilineTextAlignment(.center)
                    .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.titleBigStyle)
                RecapPriceForRecipes(
                    leadingText: String(format: String.localizedStringWithFormat(
                        Localization.myBudget.mealPlannerMealsFor(
                            numberOfMeals: Int32(params.numberOfMeals)).localised,
                        params.numberOfMeals), params.numberOfMeals),
                    priceAmount: params.totalPrice.currencyFormatted,
                    trailingText: "",
                    textFontStyle: CoursesUFontStyleProvider.sharedInstance.bodyBigStyle,
                    yellowSubtextFontStyle: CoursesUFontStyleProvider.sharedInstance.titleStyle,
                    yellowSubtextWidth: CGFloat(60))

                Divider()
                Text(Localization.myBudget.mealPlannerDiscover.localised)
                    .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.titleBigStyle)
                Button(action: {
                    params.onTapGesture()
                    showPromotions()
                }) {
                    Text("Nos promotions")
                        .foregroundColor(.white)
                        .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.bodyBigBoldStyle)
                        .padding(dimension.lPadding)
                }
                .background(Color.red)
                .cornerRadius(50) // Making the corner radius large for pill-shaped button
                .buttonStyle(PlainButtonStyle())
            }
            .padding(25)
            .background(Color.white)
            .cornerRadius(Dimension.sharedInstance.mCornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: Dimension.sharedInstance.mCornerRadius)
                    .stroke(Color.gray, lineWidth: 0.5)
            )
            .padding(.horizontal, dimension.lPadding)
        }
    }
    }
}
