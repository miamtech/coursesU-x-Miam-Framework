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
    
    public func content(recipeInfos: MiamIOSFramework.RecipeInfos, actions: BudgetRecipeCardActions) -> some View {
        CoursesURecipeCardCoreFrame(
            recipe: recipeInfos.recipe,
            price: recipeInfos.price,
            centerContent: {
            DifficultyAndTime(cookingTime: recipeInfos.recipe.cookingTimeIos, difficulty: recipeInfos.recipe.difficulty)
        }, callToAction: {
            RecipeCardCallToAction(actions: actions)
        })
    }
    
    @available(iOS 14, *)
    internal struct DifficultyAndTime: View {
        var cookingTime: String
        var difficulty: Int
        var body: some View {
            HStack() {
                MiamRecipePreparationTime(duration: cookingTime)
                Divider()
                MiamRecipeDifficulty(difficulty: difficulty)
                Spacer()
            }
        }
    }

    @available(iOS 14, *)
    internal struct RecipeCardCallToAction: View {
        var actions: BudgetRecipeCardActions
        var body: some View {
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
    }

}



@available(iOS 14, *)
struct CoursesURecipeCardCoreFrame<CenterContent: View,
                                       CallToAction: View>: View {
    var recipe: Recipe
    var price: Price
    let centerContent: () -> CenterContent
    let callToAction: () -> CallToAction
       
    public init(
        recipe: Recipe,
        price: Price,
        centerContent: @escaping () -> CenterContent,
        callToAction: @escaping () -> CallToAction)
    {
        self.recipe = recipe
        self.price = price
        self.centerContent = centerContent
        self.callToAction = callToAction
        
    }
    let dimension = Dimension.sharedInstance
    
    var body: some View {
        let priceWithCurrency = String(price.price) + (currencySymbol(forCurrencyCode: String(price.currency)) ?? "€")
        HStack(spacing: 0.0) {
            ZStack(alignment: .topLeading) {
                
                AsyncImage(url: recipe.pictureURL) { image in
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
                    Text(recipe.title + "\n")
                        .coursesUFontStyle(style: CoursesUFontStyleProvider().titleMediumStyle)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                
                centerContent()
                
                RecapPriceForRecipes(priceAmount: priceWithCurrency)
                    
                Divider()
                callToAction()
                                    
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
            CoursesUBudgetRecipeCard().content(recipeInfos: recipeInfosRandom, actions: BudgetRecipeCardActions(recipeTapped: {}, removeTapped: {
                print("Remove recipe card.")
            }, replaceTapped: nil))
            .padding()
        }
    }
}