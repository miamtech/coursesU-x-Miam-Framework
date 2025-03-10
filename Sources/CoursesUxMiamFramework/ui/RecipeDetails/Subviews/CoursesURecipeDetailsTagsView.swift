//
//  CoursesURecipeDetailsTagsView.swift
//
//
//  Created by miam x didi on 22/02/2024.
//

import mealzcore
import MealziOSSDK
import SwiftUI

@available(iOS 14, *)
public struct CoursesURecipeDetailsTagsView: RecipeDetailsTagsProtocol {
    // private let tags: [RecipeDetailTags]

    /* public init(tags: [RecipeDetailTags]) {
         self.tags = tags
     } */
    public init() {}

    func getCoursesUDifficulty(diff: String) -> String {
        switch diff {
            case "Débutant":
                return Localization.recipe.lowDifficulty.localised
            case "Avancé":
                return Localization.recipe.mediumDifficulty.localised
            case "Confirmé":
                return Localization.recipe.highDifficulty.localised
            default:
                return Localization.recipe.lowDifficulty.localised
        }
    }

    public func content(params: RecipeDetailsTagsParameters) -> some View {
        VStack {
            if let orderDate = params.orderHistory {
                HStack {
                    HStack {
                        Image.mealzIcon(icon: .exclammationPoint)
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 10, height: 10)
                            .foregroundColor(Color.mealzColor(.white))
                            .padding(Dimension.sharedInstance.sPadding)
                            .background(Circle())
                        Text("\(Localization.recipeDetails.orderedOn.localised) \(orderDate)")
                            .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodyStyle)
                    }
                    .foregroundColor(Color.mealzColor(.informativeContent))
                    .padding(Dimension.sharedInstance.mPadding)
                    .background(
                        RoundedRectangle(
                            cornerRadius: Dimension.sharedInstance.xlCornerRadius
                        )
                        .fill(Color.mealzColor(.informativeBackground))
                    )
                    .padding(.horizontal, Dimension.sharedInstance.lPadding)
                    .onTapGesture(perform: params.onClickOrderHistoryTag)
                    Spacer()
                }
            }

            Text(params.title)
                // .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.titleBigStyle)
                .coursesUFontStyle(style:
                    CoursesUFontStyleProvider.sharedInstance.titleBigStyleMulish)
                .padding(.bottom, Dimension.sharedInstance.sPadding)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack {
                ForEach(params.tags) { tag in
                    if let image = tag.mealzIcon {
                        HStack {
                            image
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color.mealzColor(.standardDarkText))
                            Text(tag.text)
                                .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodyBoldStyle)
                                .foregroundColor(Color.mealzColor(.standardDarkText))
                                .lineLimit(1)
                        }

                        /* .padding(Dimension.sharedInstance.mPadding)
                         .overlay(RoundedRectangle(cornerRadius: Dimension.sharedInstance.buttonCornerRadius)
                         .stroke(Color.mealzColor(.lightGray), lineWidth: 1.0)
                         ) */
                        .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
                        .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodyMediumStyle)
                        .background(Capsule().fill(Color.mealzColor(.lightBackground)))
                    }
                }
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(Dimension.sharedInstance.sPadding)
            .padding(.leading)
            .padding(.bottom)
        }
    }
}
