//
//  CoursesURecipeDetailsUnavailableProductView.swift
//  CoursesUxMiamFramework
//
//  Created by Damien Walerowicz on 01/12/2024.
//

import Foundation

import mealzcore
import MealziOSSDK
import SwiftUI

@available(iOS 14, *)
public struct CoursesURecipeNotInBasketProductView: NotInBasketProductProtocol {
    public init() {}
    public func content(params: NotInBasketProductParameters) -> some View {
        VStack {
            MealzRecipeDetailsIgnoredProductView.ingredientNameAndAmount(
                ingredientName: params.ingredientName,
                ingredientUnit: params.ingredientUnit,
                ingredientQuantity: params.ingredientQuantity,
                guestCount: params.guestsCount,
                defaultRecipeGuest: params.defaultRecipeGuest
            )
            MealzRecipeDetailsIgnoredProductView.willNotBeAddedText()
            MealzRecipeDetailsIgnoredProductView.ignoreOrAddProduct(onChooseProduct: params.openItemSelector)
        }
        .background(Color.mealzColor(.lightBackground))
        .cornerRadius(Dimension.sharedInstance.mCornerRadius)
        .padding(.horizontal, Dimension.sharedInstance.mPadding)
    }

    @ViewBuilder
    public static func ingredientNameAndAmount(
        ingredientName: String, ingredientUnit: String?, ingredientQuantity: String?,
        guestCount: Int, defaultRecipeGuest: Int
    ) -> some View {
        HStack {
            Text(ingredientName.capitalizingFirstLetter())
                .padding(Dimension.sharedInstance.mPadding)
                .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodyBigBoldStyle)
            Spacer()
            if let ingredientQuantity = ingredientQuantity,
               let unit = ingredientUnit
            {
                Text(QuantityFormatter.companion.readableFloatNumber(
                    value: QuantityFormatter.companion.realQuantities(
                        quantity: ingredientQuantity,
                        currentGuest: Int32(guestCount),
                        recipeGuest: Int32(defaultRecipeGuest)
                    ),
                    unit: unit
                ))
                .padding(Dimension.sharedInstance.mPadding)
                .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodyMediumStyle)
            }
        }.frame(height: 40)
    }

    @ViewBuilder
    public static func willNotBeAddedText() -> some View {
        Text(Localization.ingredient.willNotBeAdded.localised)
            .padding(Dimension.sharedInstance.mPadding)
            .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodyMediumStyle)
    }

    @ViewBuilder
    public static func ignoreOrAddProduct(onChooseProduct: @escaping () -> Void) -> some View {
        Button(action: onChooseProduct, label: {
            Text(Localization.ingredient.chooseProduct.localised).padding(Dimension.sharedInstance.mPadding)
                .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodyMediumBoldStyle)
                .foregroundColor(Color.mealzColor(.primary))
        })
        .background(Color.mealzColor(.white))
        .cornerRadius(Dimension.sharedInstance.buttonCornerRadius)
        .padding(Dimension.sharedInstance.mPadding)
    }
}
