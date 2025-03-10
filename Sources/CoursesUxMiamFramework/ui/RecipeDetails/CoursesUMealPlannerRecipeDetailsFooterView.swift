//
//  File.swift
//
//
//  Created by miam x didi on 20/02/2024.
//

import mealzcore
import MealziOSSDK
import SwiftUI

@available(iOS 14, *)
public struct CoursesUMealPlannerRecipeDetailsFooterView: RecipeDetailsFooterProtocol {
    public init() {}
    public func content(params: RecipeDetailsFooterParameters) -> some View {
        let recipeStickerPriceByGuest = params.recipeStickerPrice / Double(params.numberOfGuests)
        CoursesURecipeDetailsFooterCore(
            params: params,
            cookOnlyContent:
            CookOnlyModeFooter(
                recipeStickerPrice: params.recipeStickerPrice,
                numberOfGuests: params.numberOfGuests
            )
        )
    }

    struct CookOnlyModeFooter: View {
        private let recipeStickerPrice: Double
        private let numberOfGuests: Int
        init(recipeStickerPrice: Double, numberOfGuests: Int) {
            self.recipeStickerPrice = recipeStickerPrice
            self.numberOfGuests = numberOfGuests
        }

        var body: some View {
            HStack {
                Text((recipeStickerPrice / Double(numberOfGuests)).currencyFormatted)
                    .foregroundColor(Color.black)
                    .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.titleStyleMulish)
                Text(Localization.myMeals.perPerson.localised)
                    .foregroundColor(Color.gray)
                    .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.bodySmallStyleMulish)
                Spacer()
                RecapPriceForRecipes(priceAmount: recipeStickerPrice.currencyFormatted)
                    .frame(width: 180)
            }
        }
    }
}
