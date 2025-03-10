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
public struct CoursesUMealPlannerRecipeCard: MealPlannerRecipeCardProtocol {
    public init() {}
    public func content(params: MealPlannerRecipeCardParameters) -> some View {
        CoursesURecipeCardCoreFrame(
            recipe: params.recipe,
            price: params.recipe.attributes?.price?.price ?? 0.0,
            centerContent: {
                DifficultyTimeRecap(
                    cookingTime: params.recipe.cookingTimeIos,
                    difficulty: params.recipe.difficulty,
                    price: params.recipe.attributes?.price?.price ?? 0.0)
            }, callToAction: {
                RecipeCardCallToAction(removeTapped: params.onRemoveRecipeFromMealPlanner, replaceTapped: params.onReplaceRecipeFromMealPlanner)
            }, showRecipeDetails: params.onShowRecipeDetails)
            .frame(height: params.recipeCardDimensions.height)
    }

    @available(iOS 14, *)
    struct DifficultyTimeRecap: View {
        var cookingTime: String
        var difficulty: Int
        var price: Double
        var body: some View {
            VStack(spacing: Dimension.sharedInstance.mPadding) {
                HStack {
                    CoursesURecipePreparationTime(duration: cookingTime)
                    Divider()
                    CoursesURecipeDifficulty(difficulty: difficulty)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                RecapPriceForRecipes(priceAmount: price.currencyFormatted)
            }
        }
    }

    @available(iOS 14, *)
    struct RecipeCardCallToAction: View {
        let removeTapped: () -> Void
        let replaceTapped: () -> Void
        var body: some View {
            HStack {
                Button {
                    replaceTapped()
                } label: {
                    HStack {
                        Image(packageResource: "ReloadIcon", ofType: "png")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text(Localization.myBudget.myBudgetChangeRecipe.localised)
                            .foregroundColor(Color.mealzColor(.primary))
                            .coursesUFontStyle(style: CoursesUFontStyleProvider().bodyBigStyle)
                    }
                }
                Spacer()
                Button {
                    removeTapped()
                } label: {
                    Image(packageResource: "TrashIcon", ofType: "png")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

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

@available(iOS 14, *)
struct CoursesUMealPlannerRecipeCard_Preview: PreviewProvider {
    static var previews: some View {
        let recipe = RecipeFakeFactory().create(
            id: RecipeFakeFactory().FAKE_ID,
            attributes: RecipeFakeFactory().createAttributes(
                title: "Parmentier de Poulet",
                mediaUrl: "https://lh3.googleusercontent.com/tbMNuhJ4KxReIPF_aE0yve0akEHeN6O8hauty_XNUF2agWsmyprACLg0Zw6s8gW-QCS3A0QmplLVqBKiMmGf_Ctw4SdhARvwldZqAtMG"),
            relationships: nil)
        ZStack {
            Color.budgetBackgroundColor
            CoursesUMealPlannerRecipeCard().content(
                params: MealPlannerRecipeCardParameters(
                    recipeCardDimensions: CGSize(),
                    recipe: recipe,
                    onShowRecipeDetails: { _ in },
                    onRemoveRecipeFromMealPlanner: {},
                    onReplaceRecipeFromMealPlanner: {})
            )
            .padding()
        }
    }
}
