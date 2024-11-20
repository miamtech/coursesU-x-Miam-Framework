//
//  CoursesURecipeDetailsStepsView.swift
//  
//
//  Created by miam x didi on 22/02/2024.
//

import SwiftUI
import mealzcore
import MealziOSSDK

@available(iOS 14, *)
public struct CoursesURecipeDetailsStepsView: RecipeDetailsStepsProtocol {
    public init() {}
    public func content(params: RecipeDetailsStepsParameters) -> some View {
        VStack(alignment: .leading) {
            Text("\(params.steps.count) \(Localization.recipe.steps.localised)")
                .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.titleStyle)
                .padding()
            
            VStack {
                ForEach(Array(params.steps.enumerated()), id: \.offset) { index, step in
                    RecipeDetailStep(
                        stepNumber: index + 1,
                        stepDescription: step.attributes?.stepDescription ?? "")
                }
                .padding(.bottom)
            }.frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    internal struct RecipeDetailStep : View {
        var stepNumber: Int
        var stepDescription: String
        
        var body: some View {
            HStack{
                Text("\(stepNumber)")
                    .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.subtitleStyle)
                    .foregroundColor(Color.mealzColor(.standardLightText))
                    .frame(width: 40, height: 40)
                    .background(
                        Circle().fill(Color.mealzColor(.primary)))
                    .padding(.horizontal)
                Text(stepDescription)
                    .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodyBigStyle)
                    .foregroundColor(Color.mealzColor(.standardDarkText))
                    .padding(.trailing, 16).frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }

}
