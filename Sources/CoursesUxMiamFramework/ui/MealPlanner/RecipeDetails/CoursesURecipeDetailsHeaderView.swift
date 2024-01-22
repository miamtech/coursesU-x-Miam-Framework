//
//  CoursesURecipeDetailsHeaderView.swift
//
//
//  Created by didi on 7/6/23.
//


import SwiftUI
import MiamIOSFramework

@available(iOS 14, *)
public struct CoursesURecipeDetailsHeaderView: RecipeDetailsHeaderProtocol {
    
    public init() {}
    let imageHeight = 280.0
    public func content(params: RecipeDetailsHeaderParameters) -> some View {
        ZStack(alignment: .top) {
            if let picture =  URL(string: params.mediaURL ?? "") {
                AsyncImage(url: picture) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
                .frame(height: imageHeight)
                .clipped()
            } else {
                Image.miamImage(icon: .empty).frame( height: imageHeight)
            }
            
            HStack {
                Spacer()
                //                    CoursesULikeButton(recipeId: infos.recipeId)
            }
            //                    .frame(height: 50.0, alignment: .topLeading)
            .padding(Dimension.sharedInstance.lPadding)
        }
        HStack {
            Text(params.title)
                .coursesUFontStyle(style: CoursesUFontStyleProvider().titleStyle)
                .foregroundColor(Color.mealzColor(.darkestGray))
                .padding(.horizontal, Dimension.sharedInstance.lPadding)
                .frame( alignment: .topLeading)
            
            Spacer()
        }
        
        HStack(alignment: .center) {
            CoursesURecipePreparationTime(duration: params.totalTime)
            Divider()
                .frame(width: 8)
            CoursesURecipeDifficulty(difficulty: params.difficulty)
            Divider().frame(width: 8)
            CoursesURecipeTimeView(preparationTime: params.preparationTime,
                                   cookingTime: params.cookingTime,
                                   restingTime: params.restingTime)
            Spacer()
        }.padding(.vertical, Dimension.sharedInstance.lPadding)
            .padding(.horizontal, Dimension.sharedInstance.mPadding)
    }
}

@available(iOS 14, *)
struct CoursesURecipeTimeView: View {
    let preparationTime: String
    let cookingTime: String
    let restingTime: String
    
    let noPreparationTime = "0s"
    let noCookingTime = "0s"
    let noRestingTime = "0s"
    
    var body: some View {
        VStack(alignment: .leading) {
            if preparationTime != noPreparationTime {
                HStack(spacing: 3) {
                    Text(Localization.recipe.preparationTime.localised)
                        .coursesUFontStyle(style: CoursesUFontStyleProvider().bodyStyle)
                    Text(preparationTime)
                        .coursesUFontStyle(style: CoursesUFontStyleProvider().bodyBoldStyle)
                }
            }
            
            if cookingTime != noCookingTime {
                HStack(spacing: 3) {
                    Text(Localization.recipe.cookTime.localised)
                        .coursesUFontStyle(style: CoursesUFontStyleProvider().bodyStyle)
                    Text(cookingTime)
                        .coursesUFontStyle(style: CoursesUFontStyleProvider().bodyBoldStyle)
                }
            }
            if restingTime != noRestingTime {
                HStack(spacing: 3) {
                    Text(Localization.recipe.restingTime.localised)
                        .coursesUFontStyle(style: CoursesUFontStyleProvider().bodyStyle)
                    Text(restingTime)
                        .coursesUFontStyle(style: CoursesUFontStyleProvider().bodyBoldStyle)
                }
            }
            Spacer()
        }.padding(.horizontal, Dimension.sharedInstance.sPadding)
    }
}
