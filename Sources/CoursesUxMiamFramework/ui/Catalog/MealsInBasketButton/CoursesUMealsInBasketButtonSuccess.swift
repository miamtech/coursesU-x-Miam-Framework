//
//  CoursesUMealsInBasketButtonSuccess.swift
//
//
//  Created by miam x didi on 22/02/2024.
//

import SwiftUI
import MiamIOSFramework
import miamCore

@available(iOS 14, *)
public struct CoursesUMealsInBasketButtonSuccess: MealsInBasketButtonSuccessProtocol {
    public init() {}
    public func content(params: MealsInBasketButtonSuccessParameters) -> some View {
        Button {
            params.onNavigateToMyMeals()
        } label: {
            HStack {
                Image.mealzIcon(icon: .basket)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(Color.mealzColor(.standardLightText))
                    .frame(width: 14, height: 14)
                Spacer()
                Text("\(params.mealsCount) repas")
                    .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodyBigBoldStyle)
                    .foregroundColor(Color.mealzColor(.standardLightText))
                Spacer()
                Image.mealzIcon(icon: .caret)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(Color.mealzColor(.standardLightText))
                    .frame(width: 14, height: 14)
            }
            .frame(maxWidth: .infinity)
            .padding(Dimension.sharedInstance.lPadding)
            .padding(.horizontal, Dimension.sharedInstance.xlPadding)
        }
        .background(Color.mealzColor(.primary))
        .foregroundColor(Color.mealzColor(.standardLightText))
        .cornerRadius(Dimension.sharedInstance.buttonCornerRadius, corners: [.top])
        .padding(.horizontal, Dimension.sharedInstance.lPadding)
    }
}
