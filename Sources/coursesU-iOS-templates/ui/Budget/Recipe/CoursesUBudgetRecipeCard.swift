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
    
    let dimensions = Dimension.sharedInstance
    let cardHeight = 200.0
    public init() {}
    public func content(recipeInfos: MiamIOSFramework.RecipeInfos, actions: BudgetRecipeCardActions) -> some View {
        VStack(spacing: 0.0) {
            Divider()
            HStack(spacing: 0.0) {
                ZStack(alignment: .topTrailing) {
                    AsyncImage(url: recipeInfos.recipe.pictureURL) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .padding(0)
                            .frame(minWidth: 0, maxWidth: .infinity, maxHeight: .infinity)
                    }.padding(0)
                    HStack {
                        Button {

                        } label: {
                            Image.miamNeutralImage(icon: .heart)
                        }
                        .frame(width: dimensions.lButtonHeight, height: dimensions.lButtonHeight)
                        .background(Color.white)
                        .cornerRadius(dimensions.sCornerRadius)
                    }.padding(dimensions.lPadding)
                }
                .padding(0)
                .frame(width: 150.0)
                .clipped()

                VStack(spacing: dimensions.xlPadding) {
                    Text(recipeInfos.recipe.title + "\n")
                        .coursesUFontStyle(style: CoursesUFontStyleProvider().bodyMediumBoldStyle)
                        .lineLimit(2)
                        .multilineTextAlignment(.center)

                    HStack(spacing: dimensions.xlPadding) {
//                        MiamRecipeDifficulty(difficulty: recipeInfos.recipe.difficulty)
//                        MiamRecipePreparationTime(duration: recipeInfos.recipe.cookingTimeIos)
                    }
                    HStack {
                        Button {
                            guard let replaceTapped = actions.replaceTapped else {
                                return
                            }
                            replaceTapped()
                        } label: {
//                            Text(Localization.basket.swapProduct.localised)
                            // TODO: localize
                            Text("Hello world")
                                .coursesUFontStyle(style: CoursesUFontStyleProvider().bodyMediumBoldStyle)
                        }
                        if #unavailable(iOS 15) {
                            Spacer()
                            Button {
                                guard let removeTapped = actions.removeTapped else {
                                    return
                                }
                                removeTapped()
                            } label: {
                                Image.miamNeutralImage(icon: .bin)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                }.padding([.leading, .trailing], dimensions.lPadding)
            }
            Divider()
        }
        .padding(0)
        .frame(maxWidth: .infinity)
        .frame(height: cardHeight)
    }
}

@available(iOS 14, *)
struct CoursesUBudgetRecipeCard_Preview: PreviewProvider {
    static var previews: some View {
        let recipeAttributes = RecipeAttributes(title: "Salade grecque sur deux lignes",
                                                recipeDescription: "Coconut based recipe",
                                                numberOfGuests: 4,
                                                preparationTime: 3000000000000,
                                                cookingTime: 3000000000000,
                                                restingTime: 3000000000000,
mediaUrl: "https://hips.hearstapps.com/hmg-prod/images/is-coconut-oil-healthy-1650650710.jpg?crop=0.669xw:1.00xh;0.0637xw,0&resize=1200:*",
                                                difficulty: 3)
        let recipe = RecipeFakeFactory().create(id: "234",
                                                attributes: recipeAttributes,
                                                relationships: nil)
        let recipeInfos = RecipeInfos(recipe: recipe,
                                            price: Price(price: 21.34, currency: "EUR"),
                                            isInBasket: false)
        CoursesUBudgetRecipeCard().content(recipeInfos: recipeInfos, actions: BudgetRecipeCardActions(removeTapped: {
            print("Remove recipe card.")
        }, replaceTapped: nil))
    }
}
