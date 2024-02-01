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
public struct CoursesURecipeCard: CatalogRecipeCardProtocol {
    public init() {}
    public func content(params: CatalogRecipeCardParameters) -> some View {
        let dimensions = Dimension.sharedInstance
        var ctaAction: (String) -> Void {
            return params.isCurrentlyInBasket ? params.onShowRecipeDetails : params.onAddToBasket
        }
        let recipePrice = params.recipePrice * Double(params.numberOfGuests)
        return VStack(spacing: 0.0) {
            VStack(spacing: 0.0) {
                ZStack(alignment: .topTrailing) {
                    AsyncImage(url: params.recipe.pictureURL) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .padding(0)
                            .frame(minWidth: 0, maxWidth: .infinity, maxHeight: .infinity)
                    }.frame(height: 150.0)
                        .clipped()
                    
                    CoursesULikeButton(recipeId: params.recipe.id)
                        .padding(dimensions.mPadding)
                }
                VStack(spacing: dimensions.mPadding) {
                    Text(params.recipe.title + "\n")
                        .coursesUFontStyle(style: CoursesUFontStyleProvider().bodyMediumBoldStyle)
                        .lineLimit(2)
                        .padding(.top, dimensions.sPadding)
                    HStack(spacing: dimensions.mPadding) {
                        CoursesURecipePreparationTime(duration: params.recipe.cookingTimeIos)
                        Divider()
                            .frame(width: 5, height: 40)
                        CoursesURecipeDifficulty(difficulty: params.recipe.difficulty)
                    }
                    ZStack {
                        if params.recipePrice > 0 {
                            RecapPriceForRecipes(priceAmount: recipePrice.currencyFormatted)
                        } else {
                            ProgressLoader(color: .primaryColor)
                                .scaleEffect(0.3)
                        }
                    }.frame(height: 25)
                    Divider()
                    CoursesUButtonStyle(backgroundColor: Color.primaryColor, content: {
                        HStack {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .foregroundColor(Color.white)
                            Text(Localization.recipe.add.localised)
                                .foregroundColor(Color.white)
                                .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.bodyStyle)
                        }
                        
                    }, buttonAction: {
                        //                        actions.addToBasket(recipeInfos.recipe.id)
                        ctaAction(params.recipe.id)
                    })
                    .padding(.bottom, dimensions.sPadding)
                    .frame(maxHeight: 50)
                }
                .padding(.horizontal, dimensions.mPadding)
                .frame(maxHeight: .infinity)
            }
        }
        .padding(0)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(12.0)
        .overlay(RoundedRectangle(cornerRadius: 12.0).stroke(Color.lightGray, lineWidth: 1.0))
        .onTapGesture {
            params.onShowRecipeDetails(params.recipe.id)
        }
        .frame(height: params.recipeCardDimensions.height)
    }
}

@available(iOS 14, *)
struct CoursesURecipeCard_Previews: PreviewProvider {
    static var previews: some View {
        let recipe = RecipeFakeFactory().create(
            id: RecipeFakeFactory().FAKE_ID,
            attributes: RecipeFakeFactory().createAttributes(
                title: "Parmentier de Poulet",
                mediaUrl: "https://lh3.googleusercontent.com/tbMNuhJ4KxReIPF_aE0yve0akEHeN6O8hauty_XNUF2agWsmyprACLg0Zw6s8gW-QCS3A0QmplLVqBKiMmGf_Ctw4SdhARvwldZqAtMG"),
            relationships: nil)
        ZStack {
            Color.budgetBackgroundColor
            CoursesURecipeCard()
                .content(
                    params: CatalogRecipeCardParameters(
                        recipeCardDimensions: CGSize(width: 380, height: 100),
                        recipe: recipe,
                        recipePrice: 12.4,
                        numberOfGuests: 4,
                        isCurrentlyInBasket: false,
                        onAddToBasket: {_ in },
                        onShowRecipeDetails: {_ in}
                    )
                )
                .padding(80.0)
        }
        
    }
}
