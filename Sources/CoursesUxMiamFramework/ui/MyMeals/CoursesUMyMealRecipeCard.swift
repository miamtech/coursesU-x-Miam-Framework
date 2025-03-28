//
//  CoursesUMyMealRecipeCard.swift
//
//
//  Created by miam x didi on 22/02/2024.
//

import Foundation
import mealzcore
import MealziOSSDK
import SwiftUI

@available(iOS 14, *)
public struct CoursesUMyMealRecipeCard: MyMealRecipeCardProtocol {
    public init() {}
    public func content(params: MyMealRecipeCardParameters) -> some View {
        let pictureSize = params.recipeCardDimensions.height - (Dimension.sharedInstance.mlPadding * 2)
        
        func showTimeAndDifficulty() -> Bool {
            return params.recipeCardDimensions.height >= 320
        }
        
        func showCTA() -> Bool {
            return params.recipeCardDimensions.height >= 225
        }
        
        return VStack(alignment: .leading, spacing: 0) {
            HStack {
                ZStack(alignment: .bottomTrailing) {
                    AsyncImage(url: params.recipe.pictureURL) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: pictureSize, height: pictureSize)
                            .cornerRadius(Dimension.sharedInstance.mCornerRadius)
                    }
                    // MealzSmallGuestView(guests: params.numberOfGuests)
                    //    .padding(Dimension.sharedInstance.mPadding)
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
                }
                .frame(width: pictureSize, height: pictureSize)
                .clipped()
                Spacer()
                    .frame(width: Dimension.sharedInstance.mPadding)
                VStack(alignment: .leading, spacing: 0 /* , spacing: Dimension.sharedInstance.mPadding */ ) {
                    HStack(alignment: .top) {
                        Text(params.recipe.title)
                            // .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.titleStyle)
                            .coursesUFontStyle(style:
                                CoursesUFontStyleProvider.sharedInstance.titleStyleMulish)
                            .lineLimit(2)
                            .minimumScaleFactor(0.8)
                            
                        Spacer()
                        Button {
                            params.onDeleteRecipe()
                        } label: {
                            if params.isDeleting {
                                ProgressLoader(color: Color.mealzColor(.primary), size: 20)
                            } else {
                                Image.mealzIcon(icon: .trash)
                                    .renderingMode(.template)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color.mealzColor(.primaryText))
                            }
                        }
                    }.frame(minHeight: 20, maxHeight: 40, alignment: .top)
                        .fixedSize(horizontal: false, vertical: true)
                    Text(String(format: String.localizedStringWithFormat(
                            Localization.myMeals.products(
                                numberOfProducts: Int32(params.numberOfProductsInRecipe)).localised,
                            params.numberOfProductsInRecipe
                        ),
                        params.numberOfProductsInRecipe))
                        .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodyMediumBoldStyle)
                        .foregroundColor(Color.mealzColor(.grayText))
                    Text(params.recipePrice.currencyFormatted)
                        // .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.titleStyle)
                        .coursesUFontStyle(style:
                            CoursesUFontStyleProvider.sharedInstance.titleStyleMulish)
                        .foregroundColor(Color.mealzColor(.standardDarkText))
                        .multilineTextAlignment(.leading)
                    
                    PricePerPersonView(price: params.recipePrice, numberOfGuests: params.numberOfGuests)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
            .padding(Dimension.sharedInstance.mPadding)
        }
        .onTapGesture {
            params.onShowRecipeDetails(params.recipe.id)
        }
        .padding(Dimension.sharedInstance.mPadding)
        .frame(height: params.recipeCardDimensions.height)
        .frame(maxWidth: .infinity)
        .cornerRadius(Dimension.sharedInstance.mCornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: 12.0)
                .stroke(Color.mealzColor(.border), lineWidth: 1.0)
        )
        .padding(.horizontal, Dimension.sharedInstance.mPadding)
    }
    
    struct PricePerPersonView: View {
        var price: Double
        var numberOfGuests: Int
        
        private var pricePerPerson: Double {
            numberOfGuests != 0 ? price / Double(numberOfGuests) : 0.0
        }
        
        var body: some View {
            HStack(alignment: .bottom, spacing: 2) {
                Text(pricePerPerson.currencyFormatted)
                    .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodyMediumBoldStyle)
                    .foregroundColor(Color.mealzColor(.grayText))
                    .multilineTextAlignment(.leading)
                Text(Localization.myMeals.perPerson.localised)
                    .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodyMediumBoldStyle)
                    .foregroundColor(Color.mealzColor(.grayText))
            }
        }
    }
}
