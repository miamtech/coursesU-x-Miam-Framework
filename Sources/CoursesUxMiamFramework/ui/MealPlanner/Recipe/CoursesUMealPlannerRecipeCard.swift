//
//  MiamBudgetRecipeCard.swift
//  MiamIOSFramework
//
//  Created by Vincent Kergonna on 26/04/2023.
//  Copyright © 2023 Miam. All rights reserved.
//

import mealzcore
import MealziOSSDK
import SwiftUI

@available(iOS 14, *)
struct CoursesURecipeCardCoreFrame<
    CenterContent: View,
    CallToAction: View
>: View {
    var recipe: Recipe
    var price: Double
    let centerContent: () -> CenterContent
    let callToAction: () -> CallToAction
    let showRecipeDetails: (String) -> Void

    public init(
        recipe: Recipe,
        price: Double,
        centerContent: @escaping () -> CenterContent,
        callToAction: @escaping () -> CallToAction,
        showRecipeDetails: @escaping (String) -> Void)
    {
        self.recipe = recipe
        self.price = price
        self.centerContent = centerContent
        self.callToAction = callToAction
        self.showRecipeDetails = showRecipeDetails
    }

    let dimension = Dimension.sharedInstance

    var body: some View {
        HStack(spacing: 0.0) {
            ZStack(alignment: .topLeading) {
                AsyncImage(url: recipe.pictureURL) { image in
                    image
                        .resizable() // Make image resizable
                        .scaledToFill()
                        .padding(0)
                        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(width: 150.0)
                .clipped()
                /* HStack {
                     if recipe.isSponsored{
                         if let urlString = recipe.relationships?.sponsors?.data.first?.attributes?.logoUrl, let url = URL(string: urlString) {
                             AsyncImage(url:url) { image in
                                 image
                                     .resizable() // Make image resizable
                                     .scaledToFit().padding(8)
                                     .background(Capsule().fill(Color.white))

                             }.frame( width : 60, height: 60, alignment: .trailing)
                             Spacer()
                         }
                     }
                     Spacer()
                     CoursesULikeButton(recipeId: recipe.id)
                     .padding(dimension.mPadding)
                 } */

            }.frame(width: 150.0)
            VStack(alignment: .leading, spacing: dimension.mPadding) {
                HStack {
                    Text(recipe.title + "\n")
                        .coursesUFontStyle(style: CoursesUFontStyleProvider().titleMediumStyleMulish)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                centerContent()
                Divider()
                callToAction()
            }
            .padding(.horizontal, dimension.mPadding)
            .padding(.vertical, dimension.mPadding)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(dimension.mCornerRadius)
        .onTapGesture {
            showRecipeDetails(recipe.id)
        }
    }
}
