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

                    .padding(Dimension.sharedInstance.mPadding)
                    .overlay(RoundedRectangle(cornerRadius: Dimension.sharedInstance.buttonCornerRadius)
                        .stroke(Color.mealzColor(.lightGray), lineWidth: 1.0)
                    )
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(Dimension.sharedInstance.sPadding)
    }
}
