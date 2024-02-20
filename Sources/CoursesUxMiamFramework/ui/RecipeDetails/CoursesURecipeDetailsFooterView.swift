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
    public func content(params: RecipeDetailsFooterParameters) -> some View {
        CoursesURecipeDetailsFooterCore(
            params: params,
            cookOnlyContent:
                CookOnlyModeFooter(pricePerGuest: params.totalPriceOfProductsAddedPerGuest)
        )
    }
    
    internal struct CookOnlyModeFooter: View {
        private let pricePerGuest: Double
        init(pricePerGuest: Double) {
            self.pricePerGuest = pricePerGuest
        }
        var body: some View {
            HStack {
                Spacer()
                CoursesUPricePerPerson(pricePerGuest: pricePerGuest)
                Spacer()
            }
        }
    }
}

@available(iOS 14, *)
internal struct CoursesURecipeDetailsFooterCore<CookOnlyModeContent: View>: View {
    let params: RecipeDetailsFooterParameters
    let cookOnlyContent: CookOnlyModeContent
    public init(params: RecipeDetailsFooterParameters, cookOnlyContent: CookOnlyModeContent) {
        self.params = params
        self.cookOnlyContent = cookOnlyContent
    }
    let dimension = Dimension.sharedInstance
    
    public var body: some View {
        var lockButton: Bool {
            return params.priceStatus == ComponentUiState.locked
            || params.priceStatus == ComponentUiState.loading
            || params.isAddingAllIngredients
        }
        return HStack(spacing: 0) {
            if params.currentSelectedTab == .cooking {
                cookOnlyContent
            } else {
                if lockButton {
                    MiamIOSFramework.ProgressLoader(color: .primary, size: 24)
                } else {
                    if params.totalPriceOfProductsAdded > 0 {
                        CoursesUPricePerPerson(pricePerGuest: params.totalPriceOfProductsAddedPerGuest)
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
    
    internal struct LoadingButton: View {
        var body: some View {
            Button(action: {}, label: {
                MiamIOSFramework.ProgressLoader(color: .white, size: 24)
            })
            .padding(Dimension.sharedInstance.mlPadding)
            .background(Color.mealzColor(.primary))
            .cornerRadius(Dimension.sharedInstance.buttonCornerRadius)
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
                RoundedRectangle(cornerRadius: Dimension.sharedInstance.buttonCornerRadius)
                    .stroke(Color.mealzColor(.primary), lineWidth: 1)
            )
            .disabled(disableButton)
            .darkenView(disableButton)
        }
    }
}
