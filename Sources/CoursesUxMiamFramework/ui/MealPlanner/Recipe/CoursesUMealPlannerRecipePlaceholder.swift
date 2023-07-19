//
//  SwiftUIView.swift
//  
//
//  Created by didi on 6/7/23.
//

import SwiftUI
import miamCore
import MiamIOSFramework

@available(iOS 14, *)
public struct CoursesUMealPlannerRecipePlaceholder: MealPlannerRecipePlaceholder {
    private let recipeCardSize = CGSize(width: 175.0, height: 175.0)
    private let dimension = Dimension.sharedInstance
    public init() {}
    public func content(onTapGesture: @escaping () -> Void) -> some View {
        VStack(spacing: dimension.lPadding) {
            Circle()
                .foregroundColor(Color.primaryColor)
                .frame(width: dimension.lButtonHeight, height: dimension.lButtonHeight)
                .overlay(
                    Circle()
                        .stroke(Color.white, lineWidth: 3)
                )
                .overlay(
                    Image(systemName: "plus")
                        .resizable()
                        .foregroundColor(Color.white)
                        .frame(width: dimension.mButtonHeight, height: dimension.mButtonHeight)
                )
            Text("Ajouter une idée repas")
                .foregroundColor(Color.white)
                .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.subtitleStyle)
        }
        .frame(maxWidth: .infinity)
        .frame(height: dimension.mealPlannerRecipeCardHeight)
        .background(Color.primaryColor)
        .cornerRadius(dimension.mCornerRadius)
        .onTapGesture {
            onTapGesture()
        }
    }
}

@available(iOS 14, *)
struct CoursesUMealPlannerRecipePlaceholder_Preview: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.budgetBackgroundColor
            CoursesUMealPlannerRecipePlaceholder().content {
                
            }
        }
        
    }
}
