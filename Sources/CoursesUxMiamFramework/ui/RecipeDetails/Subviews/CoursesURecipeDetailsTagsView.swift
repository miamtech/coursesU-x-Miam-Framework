//
//  CoursesURecipeDetailsTagsView.swift
//
//
//  Created by miam x didi on 22/02/2024.
//

import SwiftUI
import MiamIOSFramework
import miamCore

@available(iOS 14, *)
public struct CoursesURecipeDetailsTagsView: View {
    private let tags: [RecipeDetailTags]
    
    public init(tags: [RecipeDetailTags]) {
        self.tags = tags
    }
    
    func getCoursesUDifficulty(diff: String) -> String {
        switch(diff) {
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
    
    
    public var body: some View {
        HStack {
            ForEach(tags, id: \.id) { tag in
                HStack {
                    Image.mealzIcon(icon: tag.picto)
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
        .frame(maxWidth: .infinity)
        .padding(Dimension.sharedInstance.sPadding)
    }
}
