//
//  CoursesURecipeDetailsFooterView.swift
//
//
//  Created by Diarmuid McGonagle on 02/02/2024.
//

import mealzcore
import MealziOSSDK
import SwiftUI

@available(iOS 14, *)
public struct CoursesURecipeDetailsFooterView: RecipeDetailsFooterProtocol {
    public init() {}
    public func content(params: RecipeDetailsFooterParameters) -> some View {
        let recipeStickerPriceByGuest = params.recipeStickerPrice / Double(params.numberOfGuests)
        var price: Double { // show full price unless items are in the basket
            if params.totalPriceOfProductsAdded > 0 { return params.totalPriceOfProductsAdded }
            else { return 0 }
        }
        if params.cookOnlyMode {
            return AnyView(CoursesURecipeDetailsFooterMealsPlanner(priceByPerson: (params.totalPriceOfRemainingProducts + params.totalPriceOfProductsAdded) / Double(params.numberOfGuests), totalPrice: params.totalPriceOfRemainingProducts + params.totalPriceOfProductsAdded))
        }
        
        return AnyView(CoursesURecipeDetailsFooterCore(
            params: params,
            cookOnlyContent:
            CookOnlyModeFooter(price: price)))
    }
    
    struct CookOnlyModeFooter: View {
        private let price: Double
        init(price: Double) {
            self.price = price
        }

        var body: some View {
            HStack {
                Spacer()
                // CoursesUPricePerPerson(pricePerGuest: pricePerGuest)
                if price == 0 {
                    EmptyView()
                } else {
                    VStack(spacing: 0) {
                        Text("\(price.currencyFormatted)")
                            .foregroundColor(Color.mealzColor(.primaryText))
                            .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.titleStyle)
                        Text(Localization.recipeDetails.inMyBasket.localised)
                            .foregroundColor(Color.mealzColor(.primaryText))
                            .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodyExtraSmallStyle)
                    }
                }
                Spacer()
            }
        }
    }
    
    struct CoursesURecipeDetailsFooterMealsPlanner: View {
        var priceByPerson: Double
        var totalPrice: Double
        
        public var body: some View {
            HStack(spacing: 0) {
                Text(priceByPerson.currencyFormatted)
                    .foregroundColor(Color.black)
                    .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.bodyBigBoldStyle)
                
                Text(Localization.price.perGuest.localised)
                    .foregroundColor(Color.mealzColor(.grayText))
                    .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.bodySmallStyle)
                Spacer()
                HStack(spacing: 0) {
                    Text("Soit ")
                        .foregroundColor(Color.black)
                        .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.bodyStyle)
                    YellowSubtext(text: totalPrice.currencyFormatted, fontStyle: CoursesUFontStyleProvider.sharedInstance.bodyBigBoldStyle, imageWidth: 55)
                    Text("le repas")
                        .foregroundColor(Color.black)
                        .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.bodyStyle)
                }.padding(.leading, 10)
                    .padding(.trailing, 10)
                    .padding(.vertical, 5)
                    .background(Color.recapTheRecipes)
                    .cornerRadius(1000)
            }
            .padding(Dimension.sharedInstance.lPadding)
            .frame(maxWidth: .infinity)
            .frame(height: 70)
            .background(Color.white)
        }
    }
}

@available(iOS 14, *)
struct CoursesURecipeDetailsFooterCore<CookOnlyModeContent: View>: View {
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
        return VStack(spacing: 0) {
            if params.currentSelectedTab == .cooking {
                cookOnlyContent
            } else {
                if lockButton {
                    // ProgressLoader(color: .primary, size: 24)
                } else {
                    if params.totalPriceOfProductsAdded > 0 {
                        HStack {
                            Text("\(params.totalPriceOfProductsAdded.currencyFormatted)")
                                .foregroundColor(Color.mealzColor(.primaryText))
                                .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.titleStyleMulish)
                            Text(Localization.recipeDetails.inMyBasket.localised)
                                .foregroundColor(Color.mealzColor(.primaryText))
                                .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodyExtraSmallStyle)
                        }
                    }
                }
                Spacer().frame(height: 10)
                if params.isAddingAllIngredients || lockButton {
                    LoadingButton()
                } else {
                    if params.ingredientsStatus.type == IngredientStatusTypes.noMoreToAdd {
                        Button(action: params.callToAction, label: {
                            Text(Localization.recipeDetails.continueShopping.localised)
                                .foregroundColor(Color.mealzColor(.primary))
                                .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.subtitleStyle)
                        })
                        .frame(maxWidth: .infinity)
                        .padding(Dimension.sharedInstance.mlPadding)
                        .overlay( /// apply a rounded border
                            RoundedRectangle(cornerRadius: 1000)
                                .stroke(Color.mealzColor(.primary), lineWidth: 1))
                        .disabled(lockButton)
                        .darkenView(lockButton)
                        
                    } else {
                        MealzAddAllToBasketCTA(
                            callToAction: params.callToAction,
                            buttonText: String(format: String.localizedStringWithFormat(
                                Localization.ingredient.addProduct(numberOfProducts: params.ingredientsStatus.count).localised,
                                params.ingredientsStatus.count),
                            params.ingredientsStatus.count).appending(" (\(params.totalPriceOfRemainingProducts.currencyFormatted))"),
                            disableButton: lockButton).cornerRadius(1000)
                    }
                }
            }
        }
        
        .padding(Dimension.sharedInstance.lPadding)
        .frame(maxWidth: .infinity)
        .frame(height: 110)
        .background(Color.white)
        .clipShape(RoundedCorner(radius: 16, corners: [.top]))
        .shadow(color: .lightGray, radius: 5).mask(Rectangle().padding(.top, -20))
    }
    
    struct LoadingButton: View {
        var body: some View {
            Button(action: {}, label: {
                ProgressLoader(color: .white, size: 24)
            })
            .padding(Dimension.sharedInstance.mlPadding)
            .background(Color.mealzColor(.primary))
            .cornerRadius(1000)
        }
    }
    
    struct ContinueMyShoppingCTA: View {
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
                RoundedRectangle(cornerRadius: 1000)
                    .stroke(Color.mealzColor(.primary), lineWidth: 1))
            .disabled(disableButton)
            .darkenView(disableButton)
        }
    }
}
