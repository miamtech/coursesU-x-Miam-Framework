//
//  CoursesURecipeDetailsFloatingHeaderView.swift
//  CoursesUxMiamFramework
//
//  Created by Damien Walerowicz on 29/11/2024.
//

import Foundation
import mealzcore
import MealziOSSDK
import SwiftUI

@available(iOS 14, *)
public struct CoursesURecipeDetailsFloatingNavigationView: RecipeDetailsFloatingNavigationProtocol {
    let thisView = CoursesURecipeDetailsFloatingNavigationView.self
    public init() {}
    public func content(
        params: RecipeDetailsFloatingNavigationParameters
    ) -> some View {
        HStack {
            if params.displayRecipeTitle {
                thisView.closePage(onRecipeDetailsClosed: params.onRecipeDetailsClosed)
                    .foregroundColor(Color.mealzColor(.white))
                    .clipShape(Circle()).padding()
                //Spacer()
                if let title = params.title {
                    Text(title)
                        .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.titleStyle)
                        .foregroundColor(Color.mealzColor(.white))
                }
            } else {
                thisView.closePage(onRecipeDetailsClosed: params.onRecipeDetailsClosed)
                    .foregroundColor(Color.mealzColor(.standardDarkText))
                    .background(Color.mealzColor(.white))
                    .clipShape(Circle()).padding()
            }
            Spacer()
            thisView.likeButton(recipeId: params.recipeId, isEnabled: params.isLikeEnabled, analyticsPath: params.analyticsPath)
        }
        .background(params.displayRecipeTitle ? Color.mealzColor(.primary) : Color.clear)
    }

    @ViewBuilder
    public static func closePage(onRecipeDetailsClosed: @escaping () -> Void) -> some View {
        Button(action: onRecipeDetailsClosed, label: {
            Image.mealzIcon(icon: .arrow)
                .renderingMode(.template)
                .rotationEffect(Angle(degrees: 180))
        }).frame(width: 40, height: 40)
            .overlay(Circle().stroke(Color.white, lineWidth: 1))
        // .foregroundColor(Color.mealzColor(.standardDarkText))
        // .background(Color.mealzColor(.white))
    }

    @ViewBuilder
    public static func likeButton(recipeId: String, isEnabled: Bool, analyticsPath: String) -> some View {
        if isEnabled {
            LikeButton(likeButtonInfo: LikeButtonInfo(recipeId: recipeId, analyticsPath: analyticsPath))
                .padding(Dimension.sharedInstance.mPadding)
        } else { EmptyView() }
    }
}
