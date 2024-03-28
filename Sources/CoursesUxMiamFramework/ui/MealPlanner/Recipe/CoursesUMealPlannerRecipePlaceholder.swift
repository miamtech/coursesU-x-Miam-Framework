//
//  SwiftUIView.swift
//  
//
//  Created by didi on 6/7/23.
//

import SwiftUI
import miamCore
import MiamIOSFramework

@available(iOS 14, *)
public struct CoursesUMealPlannerRecipePlaceholder: MealPlannerRecipePlaceholderProtocol {
    private let recipeCardSize = CGSize(width: 175.0, height: 175.0)
    private let dimension = Dimension.sharedInstance
    public init() {}
    public func content(params: MealPlannerRecipePlaceholderParameters) -> some View {
        VStack(spacing: dimension.lPadding) {
            Circle()
                .foregroundColor(Color.mealzColor(.primary))
                .frame(width: dimension.lButtonHeight, height: dimension.lButtonHeight)
                .overlay(
                    Circle()
                        .stroke(Color.white, lineWidth: 3)
                )
                .overlay(
                    Image(systemName: "plus")
                        .resizable()
                        .foregroundColor(Color.white)
                        .frame(width: dimension.mButtonHeight, height: dimension.mButtonHeight)
                )
            Text(Localization.myBudget.addMealIdea.localised)
                .foregroundColor(Color.white)
                .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.subtitleStyle)
        }
        .frame(maxWidth: .infinity)
        .frame(height: params.recipeCardDimensions.height)
        .background(Color.mealzColor(.primary))
        .cornerRadius(dimension.mCornerRadius)
        .onTapGesture {
            params.onTapGesture()
        }
    }
}

@available(iOS 14, *)
struct CoursesUMealPlannerRecipePlaceholder_Preview: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.budgetBackgroundColor
            CoursesUMealPlannerRecipePlaceholder().content(params: MealPlannerRecipePlaceholderParameters(recipeCardDimensions: CGSize(width: 300, height: 150)) {
            })
        }
    }
}
