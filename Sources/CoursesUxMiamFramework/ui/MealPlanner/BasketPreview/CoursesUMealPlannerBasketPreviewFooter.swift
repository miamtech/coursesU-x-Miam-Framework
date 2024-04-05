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
        CoursesUBudgetPlannerStickyFooter(
            budgetSpent: params.budgetSpent,
            totalBudgetPermitted: params.totalBudgetPermitted,
            footerContent:
                HStack {
                    Image(packageResource: "ShoppingCartIcon", ofType: "png")
                        .resizable()
                        .foregroundColor(Color.white)
                        .frame(width: 20, height: 20)
                    Text("Finaliser")
                        .foregroundColor(Color.white)
                        .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.bodyStyle)
                }
        ) {
            params.onNavigateToRecap()
        }
    .frame(height: params.footerHeight)
    }
}
