//
//  CoursesURecipeDetailsHeaderView.swift
//  
//
//  Created by didi on 7/6/23.
//


import SwiftUI
import MiamIOSFramework

@available(iOS 14, *)
public struct CoursesURecipeDetailsHeaderView: RecipeDetailsHeaderViewTemplate {
    
    public init() {}
    
    let imageHeight = 280.0
    
    public func content(infos: RecipeDetailsHeaderInfos, showTitleInHeader: Binding<Bool>) -> some View {
        
    
        if let template = Template.sharedInstance.recipeDetailsHeaderTemplate {
            template(infos.mediaURL,
                     infos.title,
                     infos.difficulty,
                     infos.totalTime,
                     showTitleInHeader,
                     infos.isLikeEnabled,
                     infos.recipeId)
        } else {
            ZStack(alignment: .top) {
                if let picture =  URL(string: infos.mediaURL ?? "") {
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
                
                if infos.isLikeEnabled {
                    HStack {
                        Spacer()
                        CoursesULikeButton(recipeId: infos.recipeId)
                    }
//                    .frame(height: 50.0, alignment: .topLeading)
                    .padding(Dimension.sharedInstance.lPadding)
                }
            }
            HStack {
                Text(infos.title)
                    .coursesUFontStyle(style: CoursesUFontStyleProvider().titleStyle)
                    .foregroundColor(Color.miamColor(.black))
                    .padding(.horizontal, Dimension.sharedInstance.lPadding)
                    .frame( alignment: .topLeading)
                    
                Spacer()
            }

            HStack(alignment: .center) {
                CoursesURecipePreparationTime(duration: infos.totalTime)
                Divider()
                    .frame(width: 8)
                CoursesURecipeDifficulty(difficulty: infos.difficulty)
                Divider().frame(width: 8)
                CoursesURecipeTimeView(preparationTime: infos.preparationTime,
                               cookingTime: infos.cookingTime,
                               restingTime: infos.restingTime)
                Spacer()
            }.padding(.vertical, Dimension.sharedInstance.lPadding)
                .padding(.horizontal, Dimension.sharedInstance.lPadding)
        }
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
        if let template = Template.sharedInstance.recipeTimeViewTemplate {
            template(preparationTime, cookingTime, restingTime)
        } else {
            VStack(alignment: .leading) {
                if preparationTime != noPreparationTime {
                    HStack {
                        Text(RecipeDetailsText.sharedInstance.preparationTime)
                            .coursesUFontStyle(style: CoursesUFontStyleProvider().bodyStyle)
                            
                        Text(preparationTime)
                            .coursesUFontStyle(style: CoursesUFontStyleProvider().bodyBoldStyle)
                    }
                }

                if cookingTime != noCookingTime {
                    HStack {
                        Text(RecipeDetailsText.sharedInstance.cookingTime)
                            .coursesUFontStyle(style: CoursesUFontStyleProvider().bodyStyle)
                            
                        Text(cookingTime)
                            .coursesUFontStyle(style: CoursesUFontStyleProvider().bodyBoldStyle)
                    }
                }

                if restingTime != noRestingTime {
                    HStack {
                        Text(RecipeDetailsText.sharedInstance.restingTime)
                            .coursesUFontStyle(style: CoursesUFontStyleProvider().bodyStyle)
                           
                        Text(restingTime)
                            .coursesUFontStyle(style: CoursesUFontStyleProvider().bodyBoldStyle)
                    }
                }
                Spacer()
            }.padding(.horizontal, Dimension.sharedInstance.lPadding)
        }

    }
}
