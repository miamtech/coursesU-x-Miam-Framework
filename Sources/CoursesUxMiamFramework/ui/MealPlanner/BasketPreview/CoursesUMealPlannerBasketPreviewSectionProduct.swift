//
//  SwiftUIView.swift
//  
//
//  Created by didi on 6/22/23.
//

import SwiftUI
import MiamIOSFramework
import miamCore

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
                        HStack {
                            Image(systemName: "plus")
                                .resizable()
                                .foregroundColor(Color.black)
                                .frame(width: 15, height: 15)
                            Text("Ajouter")
                                .foregroundColor(Color.black)
                                .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.bodyStyle)
                        }
                    })
                }
            }
            .padding(Dimension.sharedInstance.lPadding)
            .frame(maxWidth: .infinity)
        }
    }
}
