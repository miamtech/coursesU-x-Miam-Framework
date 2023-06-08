//
//  MiamRecipeCard.swift
//  MiamIOSFramework
//
//  Created by Vincent Kergonna on 26/05/2023.
//  Copyright © 2023 Miam. All rights reserved.
//

import SwiftUI
import miamCore
import MiamIOSFramework

@available(iOS 14, *)
public struct CoursesURecipeCard: RecipeCard {
    public init() {}
    public func content(recipeInfos: MiamIOSFramework.RecipeInfos, actions: RecipeCardActions) -> some View {
        let cardHeight = 340.0
        let dimensions = Dimension.sharedInstance
        var ctaAction: () -> Void {
            return recipeInfos.isInBasket ? actions.showDetails : actions.addToBasket
        }
        let priceWithCurrency = String(recipeInfos.price.price)  +
        (
            currencySymbol(forCurrencyCode: recipeInfos.price.currency)
            ?? "€"        )
        
        VStack(spacing: 0.0) {
            VStack(spacing: 0.0) {
                ZStack(alignment: .topTrailing) {
                    AsyncImage(url: recipeInfos.recipe.pictureURL) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .padding(0)
                            .frame(minWidth: 0, maxWidth: .infinity, maxHeight: .infinity)
                    }.padding(0)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "heart")
                    }
                    .frame(width: dimensions.lButtonHeight, height: dimensions.lButtonHeight)
                    .background(Color.white)
                    .cornerRadius(dimensions.sCornerRadius)
                    .padding(dimensions.lPadding)
                }
                .padding(0)
                .frame(height: 150.0)
                .clipped()
                
                VStack(spacing: dimensions.mPadding) {
                    Text(recipeInfos.recipe.title + "\n")
                        .coursesUFontStyle(style: CoursesUFontStyleProvider().bodyMediumBoldStyle)
                        .lineLimit(2)
                    //                        .multilineTextAlignment(.center)
                    
                    HStack(spacing: dimensions.xlPadding) {
                        MiamRecipeDifficulty(difficulty: recipeInfos.recipe.difficulty)
                        MiamRecipePreparationTime(duration: recipeInfos.recipe.cookingTimeIos)
                        Spacer()
                    }
                    RecapPriceForRecipes(priceAmount: priceWithCurrency)
                    Divider()
                    CoursesUButtonStyle(backgroundColor: Color.primaryColor, content: {
                        HStack {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .foregroundColor(Color.white)
                            Text("Ajouter!")
                                .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.bodyStyle)
                                .foregroundColor(Color.white)
                        }
                        
                    }, buttonAction: { ctaAction()})
                }
                .padding(.horizontal, dimensions.lPadding)
                .frame(maxHeight: .infinity)
            }
        }
        .padding(0)
        .frame(maxWidth: .infinity)
        .frame(height: cardHeight)
        .background(Color.white)
        .cornerRadius(12.0)
        
        .overlay(RoundedRectangle(cornerRadius: 12.0).stroke(Color.lightGray, lineWidth: 1.0))
    }
}

@available(iOS 14, *)
struct CoursesURecipeCard_Previews: PreviewProvider {
    static var previews: some View {
        let recipe = RecipeFakeFactory().create(id: RecipeFakeFactory().FAKE_ID,
                                                
                                                attributes: RecipeFakeFactory().createAttributes(title: "Parmentier de Poulet",
                                                                                                 mediaUrl: "https://hips.hearstapps.com/hmg-prod/images/is-coconut-oil-healthy-1650650710.jpg?crop=0.669xw:1.00xh;0.0637xw,0&resize=1200:*"),
                                                relationships: nil)
        let infos = RecipeInfos(recipe: recipe, price: Price(price: 30.0, currency: "EUR"), isInBasket: true)
        ZStack {
            Color.budgetBackgroundColor
            CoursesURecipeCard().content(recipeInfos: infos, actions: RecipeCardActions(like: {}, addToBasket: {}, showDetails: {}))
                .padding(80.0)
        }
        
    }
}
