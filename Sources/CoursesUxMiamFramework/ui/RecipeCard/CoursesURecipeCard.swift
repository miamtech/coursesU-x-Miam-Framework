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
public struct CoursesURecipeCard: CatalogRecipeCardProtocol {
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
            VStack(spacing: 0.0) {
                ZStack {
                    AsyncImage(url: params.recipe.pictureURL) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .padding(0)
                            .frame(width: params.recipeCardDimensions.width, height: pictureHeight)
                            .clipped()
                    }
                    .contentShape(Rectangle()) // this fixes gesture detector overflow to other cards
                    .padding(0)
                    LinearGradient(
                        gradient: Gradient(
                            colors: [Color.clear, Color.black.opacity(0.3)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    VStack(alignment: .trailing, spacing: 0) {
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
                            VStack {
                                if let discountedIngredientCount = params.recipe.attributes?.discountedIngredientCount,
                                   discountedIngredientCount != 0
                                {
                                    HStack {
                                        Image(packageResource: "discountTag", ofType: "png")
                                            .resizable()
                                            .frame(width: 119, height: 40)
                                        Spacer()
                                    }
                                }
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
                            }
                            if showingOnCatalogResults {
                                CoursesULikeButton(recipeId: params.recipe.id)
                                /* LikeButton(
                                 likeButtonInfo: LikeButtonInfo(
                                     recipeId: params.recipe.id,
                                     backgroundColor: Color.white
                                 )) */
                            }
                        }.padding(dimensions.mPadding)
                        Spacer()
                        HStack {
                            Text(params.recipe.title)
                                .foregroundColor(Color.mealzColor(.white))
                                // .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodyBigBoldStyle)
                                .coursesUFontStyle(style:
                                    CoursesUFontStyleProvider.sharedInstance.bodyBigBoldStyleMulish)
                                .lineLimit(2)
                                .multilineTextAlignment(.leading)
                                .minimumScaleFactor(0.75)
                            Spacer()
                            // MealzSmallGuestView(guests: Int(params.numberOfGuests))
                            HStack(spacing: 2) {
                                Text(String(params.numberOfGuests))
                                    .foregroundColor(Color.mealzColor(.darkestGray))
                                    // .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodyBoldStyle)
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
                .frame(width: params.recipeCardDimensions.width, height: pictureHeight)
                .clipped()
                HStack {
                    CoursesUPricePerPerson(pricePerGuest: params.recipe.attributes?.price?.pricePerServe ?? params.recipePrice)
                    Spacer()
                    if !showingOnCatalogResults {
                        CoursesULikeButton(recipeId: params.recipe.id)
                        /* LikeButton(
                         likeButtonInfo: LikeButtonInfo(
                             recipeId: params.recipe.id,
                             backgroundColor: Color.white
                         )) */
                    }
                    CallToAction(cardWidth: params.recipeCardDimensions.width, isCurrentlyInBasket: params.isCurrentlyInBasket) {
                        params.onAddToBasket(params.recipe.id)
                    }
                }
                .frame(height: callToActionHeight)
                .padding(.horizontal, Dimension.sharedInstance.mlPadding)
            }
        }
        .onTapGesture {
            params.onShowRecipeDetails(params.recipe.id)
        }
        .padding(0)
        .frame(width: params.recipeCardDimensions.width, height: params.recipeCardDimensions.height)
        .background(Color.mealzColor(.white))
        .cornerRadius(Dimension.sharedInstance.lCornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: Dimension.sharedInstance.lCornerRadius)
                .stroke(Color.mealzColor(.border), lineWidth: 1.0))
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
                            .frame(width: 24, height: 24)
                    } else {
                        Image.mealzIcon(icon: .basket)
                            .renderingMode(.template)
                            .resizable()
                            .foregroundColor(Color.mealzColor(.white))
                            .frame(width: 24, height: 24)
                    }
                })
                .padding(Dimension.sharedInstance.mlPadding)
                .background(
                    Circle()
                        .stroke(Color.mealzColor(.primary), lineWidth: 1)
                        .background(Circle().fill(!isCurrentlyInBasket ? Color.mealzColor(.primary) : Color.clear))
                )
                .frame(width: 34, height: 34)
            }
        }
    }
}

/*@available(iOS 14, *)
 struct CoursesURecipeCard_Previews: PreviewProvider {
     static var previews: some View {
         let recipe = RecipeFakeFactory().create(
             id: RecipeFakeFactory().FAKE_ID,
             attributes: RecipeFakeFactory().createAttributes(
                 title: "Parmentier de Poulet",
                 mediaUrl: "https://lh3.googleusercontent.com/tbMNuhJ4KxReIPF_aE0yve0akEHeN6O8hauty_XNUF2agWsmyprACLg0Zw6s8gW-QCS3A0QmplLVqBKiMmGf_Ctw4SdhARvwldZqAtMG"),
             relationships: nil)
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
         ))
         .padding(80.0)
     }
 }
 */
