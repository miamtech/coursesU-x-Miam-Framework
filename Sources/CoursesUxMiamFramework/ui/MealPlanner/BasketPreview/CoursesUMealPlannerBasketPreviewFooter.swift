//
//  CoursesUMealPlannerBasketPreviewFooter.swift
//
//
//  Created by Diarmuid McGonagle on 30/01/2024.
//

import SwiftUI
import MiamIOSFramework

@available(iOS 14, *)
public struct CoursesUMealPlannerBasketPreviewFooter: MealPlannerBasketFooterProtocol {
    public init() {}
    public func content(params: MealPlannerBasketFooterParamaters) -> some View {
        HStack {
            ZStack {
                if params.isLoading {
                    ProgressLoader(color: Color.primary).scaleEffect(0.6)
                } else {
                    Text(params.totalPrice.currencyFormatted)
                        .foregroundColor(Color.black)
                        .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.titleStyle)
                }
            }
            .padding(Dimension.sharedInstance.lPadding)
            Button {
                params.onNavigateToRecap()
            } label: {
                Text(Localization.basket.continueShopping.localised)
            }
            .padding(Dimension.sharedInstance.lPadding)
            .frame(maxWidth: .infinity)
            .foregroundColor(Color.white)
            .background(Color.mealzColor(.primary))
            .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodyBigBoldStyle)
            .cornerRadius(Dimension.sharedInstance.mCornerRadius)
            .disabled(params.isLoading)
            .darkenView(params.isLoading)
        }
        .padding(.vertical, Dimension.sharedInstance.mPadding)
        .padding(.horizontal, Dimension.sharedInstance.mPadding)
        .frame(height: params.footerHeight)
        .background(Color.mealzColor(.standardLightText))
    }
}

@available(iOS 14, *)
struct CoursesUMealPlannerBasketPreviewFooter_Previews: PreviewProvider {
    static var previews: some View {
        CoursesUMealPlannerBasketPreviewFooter().content(
            params: MealPlannerBasketFooterParamaters(
                footerHeight: 150,
                totalPrice: 45.2,
                isLoading: false,
                onNavigateToRecap: {}, onNavigateToBasket: {}
            )
        )
    }
}
