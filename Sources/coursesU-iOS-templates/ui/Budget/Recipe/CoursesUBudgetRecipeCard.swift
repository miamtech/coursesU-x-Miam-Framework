//
//  MiamBudgetRecipeCard.swift
//  MiamIOSFramework
//
//  Created by Vincent Kergonna on 26/04/2023.
//  Copyright © 2023 Miam. All rights reserved.
//

import SwiftUI
import miamCore
import MiamIOSFramework

@available(iOS 14, *)
public struct CoursesUBudgetRecipeCard: BudgetRecipeCard {
    public init() {}
    let dimension = Dimension.sharedInstance
    
    public func content(recipeInfos: MiamIOSFramework.RecipeInfos, actions: BudgetRecipeCardActions) -> some View {
        let priceWithCurrency = String(recipeInfos.price.price) + (currencySymbol(forCurrencyCode: String(recipeInfos.price.currency)) ?? "€")
        HStack(spacing: 0.0) {
            ZStack(alignment: .topLeading) {
                
                AsyncImage(url: recipeInfos.recipe.pictureURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .padding(0)
                        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(width: 150.0)
                .clipped()
                CoursesULikeButton {
                    print("pressed like")
                }
                .padding(dimension.mPadding)
            }
            
            VStack(spacing: dimension.mPadding) {
                
                HStack {
                    Text(recipeInfos.recipe.title + "\n")
                        .coursesUFontStyle(style: CoursesUFontStyleProvider().titleMediumStyle)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                
                
                HStack() {
                    MiamRecipePreparationTime(duration: recipeInfos.recipe.cookingTimeIos)
                    Divider()
                    MiamRecipeDifficulty(difficulty: recipeInfos.recipe.difficulty)
                    Spacer()
                }
                RecapPriceForRecipes(priceAmount: priceWithCurrency)
                    
                Divider()
                HStack {
                    Button {
                        guard let replaceTapped = actions.replaceTapped else {
                            return
                        }
                        replaceTapped()
                    } label: {
                        HStack {
                            Image(packageResource: "ReloadIcon", ofType: "png")
                                .resizable()
                                .frame(width: 20, height: 20)
                            //                            Text(Localization.basket.swapProduct.localised)
                            // TODO: localize
                            Text("Changer")
                                .foregroundColor(Color.primaryColor)
                                .coursesUFontStyle(style: CoursesUFontStyleProvider().bodyBigStyle)
                        }
                    }
                                        if #unavailable(iOS 15) {
                    Spacer()
                    Button {
                        guard let removeTapped = actions.removeTapped else {
                            return
                        }
                        removeTapped()
                    } label: {
                        Image(packageResource: "TrashIcon", ofType: "png")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                                        }
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, dimension.lPadding)
            .padding(.vertical, dimension.mPadding)
        }
        .frame(maxWidth: .infinity)
        .frame(height: dimension.mealPlannerRecipeCardHeight)
        .background(Color.white)
        .cornerRadius(dimension.mCornerRadius)
    }
}

@available(iOS 14, *)
struct CoursesUBudgetRecipeCard_Preview: PreviewProvider {
    static var previews: some View {
        let recipeInfosRandom = FakeRecipe().createRandomFakeRecipeInfos()
        ZStack {
            Color.budgetBackgroundColor
            CoursesUBudgetRecipeCard().content(recipeInfos: recipeInfosRandom, actions: BudgetRecipeCardActions(removeTapped: {
                print("Remove recipe card.")
            }, replaceTapped: nil))
            .padding()
        }
    }
}
