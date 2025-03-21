//
//  CoursesURecipeCard.swift
//  MiamIOSFramework
//
//  Created by Vincent Kergonna on 26/05/2023.
//  Copyright © 2023 Miam. All rights reserved.
//

import mealzcore
import MealziOSSDK
import SwiftUI

@available(iOS 14, *)
public struct CoursesUStandaloneRecipeCard: CatalogRecipeCardProtocol {
    let showYellowBanner: Bool
    let showingOnCatalogResults: Bool
    public init(
        showYellowBanner: Bool = false,
        showingOnCatalogResults: Bool = false
    ) {
        self.showYellowBanner = showYellowBanner
        self.showingOnCatalogResults = showingOnCatalogResults
    }

    public func content(params: CatalogRecipeCardParameters) -> some View {
        let dimensions = Dimension.sharedInstance
        let callToActionHeight: CGFloat = 70
        let pictureHeight = params.recipeCardDimensions.height - callToActionHeight

        func showTimeAndDifficulty() -> Bool {
            return params.recipeCardDimensions.height >= 320
        }

        return VStack(spacing: 0.0) {
            HStack(spacing: 0.0) {
                GeometryReader { reader in
                    ZStack {
                        AsyncImage(url: params.recipe.pictureURL) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .padding(0)
                                .frame(width: reader.size.width, height: 200)
                                .clipped()
                        }
                        .contentShape(Rectangle()) // this fixes gesture detector overflow to other cards
                        .padding(0)
                        VStack(spacing: 0) {
                            HStack {
                                if showYellowBanner {
                                    if params.recipe.isADrink {
                                        Image(packageResource: "MealIdeasDrinks", ofType: "png")
                                            .resizable()
                                            .frame(width: 120, height: 42)
                                    } else {
                                        Image(packageResource: "MealIdeas", ofType: "png")
                                            .resizable()
                                            .frame(width: 110, height: 42)
                                    }
                                    Spacer()
                                }
                            }.padding(dimensions.mPadding)
                            Spacer()
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
                                // MealzSmallGuestView(guests: Int(params.numberOfGuests))
                                HStack(spacing: 2) {
                                    Text(String(params.numberOfGuests))
                                        .foregroundColor(Color.mealzColor(.darkestGray))
                                        .coursesUFontStyle(style:
                                            CoursesUFontStyleProvider.sharedInstance.bodyBoldStyleMulish)
                                    Image(packageResource: "guestsNumber", ofType: "png")
                                        .renderingMode(.template)
                                        .resizable()
                                        .foregroundColor(Color.mealzColor(.darkestGray))
                                        .frame(width: 13, height: 13)
                                }
                                .padding(.horizontal, Dimension.sharedInstance.mPadding)
                                .padding(.vertical, Dimension.sharedInstance.sPadding)
                                .background(Color.mealzColor(.white))
                                .cornerRadius(50)
                            }.padding(Dimension.sharedInstance.mlPadding)
                        }
                    }
                    .padding(0)
                    .frame(height: 200)
                    .frame(maxWidth: .infinity)
                    .clipped()
                }
                VStack(alignment: .leading) {
                    Text(params.recipe.title)
                        .foregroundColor(Color.mealzColor(.primaryText))
                        // .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodyBigBoldStyle)
                        .coursesUFontStyle(style:
                            CoursesUFontStyleProvider.sharedInstance.bodyBigBoldStyleMulish)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .minimumScaleFactor(0.75)
                    Spacer()
                    if let discountedIngredientCount = params.recipe.attributes?.discountedIngredientCount,
                       discountedIngredientCount != 0
                    {
                        HStack {
                            Image(packageResource: "discountTag", ofType: "png")
                                .resizable()
                                .frame(width: 90, height: 30)
                            Spacer()
                        }.padding(dimensions.mPadding)
                    }
                    HStack(spacing: 0) {
                        CoursesUPricePerPerson(pricePerGuest: params.recipe.attributes?.price?.pricePerServe ?? params.recipePrice)
                        Spacer()

                        CoursesULikeButton(recipeId: params.recipe.id)
                        CallToAction(cardWidth: params.recipeCardDimensions.width, isCurrentlyInBasket: params.isCurrentlyInBasket) {
                            params.onAddToBasket(params.recipe.id)
                        }.padding(.trailing, 6)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(Dimension.sharedInstance.mlPadding)
            }
        }
        .padding(0)
        .frame(height: 200)
        .frame(maxWidth: .infinity)
        .background(Color.mealzColor(.white))
        .cornerRadius(Dimension.sharedInstance.lCornerRadius)
        .onTapGesture {
            params.onShowRecipeDetails(params.recipe.id)
        }
        .overlay(
            RoundedRectangle(cornerRadius: Dimension.sharedInstance.lCornerRadius)
                .stroke(Color.mealzColor(.border), lineWidth: 1.0))
        .padding(.horizontal, 16)
    }

    struct CallToAction: View {
        let cardWidth: CGFloat
        let isCurrentlyInBasket: Bool
        let callToAction: () -> Void
        var body: some View {
            VStack {
                Button(action: callToAction, label: {
                    if isCurrentlyInBasket {
                        Image.mealzIcon(icon: .basketCheck)
                            .renderingMode(.template)
                            .resizable()
                            .foregroundColor(Color.mealzColor(.primary))
                            .frame(width: 18, height: 18)
                    } else {
                        Image.mealzIcon(icon: .basket)
                            .renderingMode(.template)
                            .resizable()
                            .foregroundColor(Color.mealzColor(.white))
                            .frame(width: 18, height: 18)
                    }
                })
                .padding(Dimension.sharedInstance.mlPadding)
                .frame(width: 40, height: 40)
                .background(
                    Circle()
                        .stroke(Color.primaryColor, lineWidth: 1)
                        .background(Circle().fill(!isCurrentlyInBasket ? Color.primaryColor : Color.clear))
                )
            }
        }
    }
}
