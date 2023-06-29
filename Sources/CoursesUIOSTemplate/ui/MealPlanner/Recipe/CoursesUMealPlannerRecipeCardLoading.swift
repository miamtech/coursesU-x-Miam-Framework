//
//  BudgetRecipeCardLoadingView.swift
//  MiamIOSFramework
//
//  Created by Vincent Kergonna on 16/05/2023.
//  Copyright © 2023 Miam. All rights reserved.
//

import SwiftUI
import miamCore
import MiamIOSFramework

@available(iOS 14, *)
public struct CoursesUMealPlannerRecipeCardLoading: MealPlannerRecipeCardLoading {
   
    let dimensions = Dimension.sharedInstance
    @SwiftUI.State private var opacity: Double = 0.5
    public init() {}
    
    public func content() -> some View {
            
        ProgressLoader(color: Color.primaryColor)
            .frame(maxWidth: .infinity)
            .frame(height: dimensions.mealPlannerRecipeCardHeight)
            .redacted(reason: .placeholder)
            .background(Color.white)
            .opacity(opacity)
            .overlay(
                RoundedRectangle(cornerRadius: dimensions.mPadding)
                    .stroke(style: StrokeStyle(lineWidth: 4, dash: [15, 20]))
                    .foregroundColor(Color.primaryColor)
            )
            .cornerRadius(Dimension.sharedInstance.mCornerRadius)
    }
}

@available(iOS 14, *)
struct CoursesUMealPlannerRecipeCardLoading_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.budgetBackgroundColor
            CoursesUMealPlannerRecipeCardLoading().content()
                .padding()
        }
        
    }
}
