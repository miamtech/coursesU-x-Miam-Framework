//
//  CoursesURecipePickerRecipeCard.swift
//
//
//  Created by Diarmuid McGonagle on 08/02/2024.
//

import mealzcore
import MealziOSSDK
import SwiftUI

@available(iOS 14, *)
public struct CoursesURecipePickerRecipeCard: CatalogRecipeCardProtocol {
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

                    HStack {
                        if params.recipe.isSponsored {
                            if let urlString = params.recipe.relationships?.sponsors?.data.first?.attributes?.logoUrl, let url = URL(string: urlString) {
                                AsyncImage(url: url) { image in
                                    image
                                        .resizable() // Make image resizable
                                        .scaledToFit().padding(8)
                                        .background(Capsule().fill(Color.white))

                                }.frame(width: 60, height: 60, alignment: .trailing)
                                Spacer()
                            }
                        }
                        Spacer()
                        CoursesULikeButton(recipeId: params.recipe.id)
                            .padding(dimensions.mPadding)
                    }
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
                            ProgressLoader(color: .mealzColor(.primary))
                                .scaleEffect(0.3)
                        }
                    }.frame(height: 25)
                    Divider()
                    CoursesUButtonStyle(backgroundColor: Color.mealzColor(.primary), content: {
                        HStack {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .foregroundColor(Color.white)
                            Text(Localization.preferences.addTag.localised)
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
        // .frame(height: 300)
    }
}
