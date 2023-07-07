//
//  CoursesURecipeDetailsStepsView.swift
//  
//
//  Created by didi on 7/6/23.
//

import SwiftUI
import MiamIOSFramework
import miamCore

@available(iOS 14, *)
public struct CoursesURecipeDetailsStepsView: RecipeDetailsStepsViewTemplate {
    
    public init() {}
    
    @SwiftUI.State private var activeStep = -1
    
    public func content(steps: [RecipeStep]) -> some View {

        if let template = Template.sharedInstance.recipeDetailStepsViewTemplate {
            template(steps)
        } else {
            HStack {
                Text("Étapes")
                    .foregroundColor(Color.black)
                    .coursesUFontStyle(style: CoursesUFontStyleProvider().titleStyle)
                    .padding(Dimension.sharedInstance.lPadding)
                Spacer()
            }.frame(height: 60.0, alignment: .topLeading)
                .padding(.top, Dimension.sharedInstance.lPadding)

            // Steps
            Divider()
                .background(Color.lightGray)
                .padding(.horizontal, Dimension.sharedInstance.lPadding)

            // Steps ListView
            VStack {
                VStack {
                    ForEach(Array(steps.enumerated()), id: \.element) { index, step in
                        let isChecked = activeStep > index
                        RecipeDetailsStepRow(
                            index: index,
                            step: step,
                            isCheck: isChecked,
                            onToogleCheckbox: {
                                activeStep = index + 1
                            }
                        )
                    }
                }.padding(.vertical, Dimension.sharedInstance.lPadding)
            }.padding( .horizontal, Dimension.sharedInstance.lPadding)
        }
    }
}
