//
//  SwiftUIView.swift
//
//
//  Created by didi on 6/22/23.
//

import mealzcore
import MealziOSSDK
import SwiftUI

@available(iOS 14, *)
public struct CoursesUMealPlannerBasketPreviewSectionProduct: NotInBasketProductProtocol {
    public init() {}
    public func content(params: NotInBasketProductParameters) -> some View {
        HStack {
            HStack {
                Text(params.ingredientName.capitalizingFirstLetter())
                    .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.subtitleStyle)
                Spacer()
                //                }
                if let addIngredientAction = params.onAddToBasket {
                    Button(action: {
                        addIngredientAction()
                    }, label: {
                        if params.isLocked {
                            ProgressLoader(color: Color.mealzColor(.primary), size: 20)
                        } else {
                            HStack {
                                Image(systemName: "plus")
                                    .resizable()
                                    .foregroundColor(Color.black)
                                    .frame(width: 15, height: 15)
                                Text(Localization.recipe.add.localised)
                                    .foregroundColor(Color.black)
                                    .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.bodyStyle)
                            }
                        }
                    })
                }
            }
            .padding(Dimension.sharedInstance.lPadding)
            .frame(maxWidth: .infinity)
        }
    }
}
