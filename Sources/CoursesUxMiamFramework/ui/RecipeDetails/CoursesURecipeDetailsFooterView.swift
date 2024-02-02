//
//  CoursesURecipeDetailsFooterView.swift
//  
//
//  Created by Diarmuid McGonagle on 02/02/2024.
//

import SwiftUI
import miamCore
import MealzUIModuleIOS
import MiamIOSFramework

@available(iOS 14, *)
public struct CoursesURecipeDetailsFooterView: RecipeDetailsFooterProtocol {
    
    public init() {}
    let dimension = Dimension.sharedInstance
    
    public func content(params: RecipeDetailsFooterParameters) -> some View {
        var lockButton: Bool {
            return params.priceStatus == ComponentUiState.locked
            || params.priceStatus == ComponentUiState.loading
            || params.isAddingAllIngredients
        }
        return HStack(spacing: 0) {
            if params.cookOnlyMode {
                CookOnlyModeFooter(
                    recipeStickerPrice: params.recipeStickerPrice,
                    numberOfGuests: params.numberOfGuests)
            } else {
            if lockButton {
                MiamIOSFramework.ProgressLoader(color: .primary, size: 24)
            } else {
                if params.totalPriceOfProductsAdded > 0 {
                    MealzPricePerPerson(pricePerGuest: params.totalPriceOfProductsAddedPerGuest)
                }
            }
            Spacer()
                if params.isAddingAllIngredients {
                    LoadingButton()
                } else {
                    switch params.ingredientsStatus.type {
                    case .noMoreToAdd:
                        ContinueMyShoppingCTA(
                            callToAction: params.callToAction,
                            buttonText: Localization.recipeDetails.continueShopping.localised,
                            disableButton: lockButton)
                    case .initialState:
                        MealzAddAllToBasketCTA(
                            callToAction: params.callToAction,
                            buttonText: Localization.recipeDetails.addAllProducts.localised,
                            disableButton: lockButton)
                    default:
                        MealzAddAllToBasketCTA(
                            callToAction: params.callToAction,
                            buttonText: String(format: String.localizedStringWithFormat(
                                Localization.ingredient.addProduct(numberOfProducts: params.ingredientsStatus.count).localised,
                                params.ingredientsStatus.count),
                                               params.ingredientsStatus.count),
                            disableButton: lockButton)
                    }
                }
            }
        }
        .padding(Dimension.sharedInstance.lPadding)
        .frame(maxWidth: .infinity)
        .frame(height: 70)
        .background(Color.white)
    }
    
    internal struct CookOnlyModeFooter: View {
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
                    .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.titleStyle)
                Text(Localization.myMeals.perPerson.localised)
                    .foregroundColor(Color.gray)
                    .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.bodySmallStyle)
                Spacer()
                RecapPriceForRecipes(priceAmount:  recipeStickerPrice.currencyFormatted)
            }
        }
    }
    
    internal struct LoadingButton: View {
        var body: some View {
            Button(action: {}, label: {
                MiamIOSFramework.ProgressLoader(color: .white, size: 24)
            })
            .padding(Dimension.sharedInstance.mlPadding)
            .background(Color.mealzColor(.primary))
            .cornerRadius(Dimension.sharedInstance.mPadding)
        }
    }
    
    internal struct ContinueMyShoppingCTA: View {
        let callToAction: () -> Void
        let buttonText: String
        let disableButton: Bool
        
        var body: some View {
            Button(action: callToAction, label: {
                Text(buttonText)
                    .foregroundColor(Color.mealzColor(.primary))
                    .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.subtitleStyle)
            })
            .padding(Dimension.sharedInstance.mlPadding)
            .overlay( /// apply a rounded border
                RoundedRectangle(cornerRadius: Dimension.sharedInstance.mCornerRadius)
                    .stroke(Color.mealzColor(.primary), lineWidth: 1)
            )
            .disabled(disableButton)
            .darkenView(disableButton)
        }
    }
}
