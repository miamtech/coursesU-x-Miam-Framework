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
public struct CoursesUMealPlannerBasketPreviewSectionProduct: MealPlannerBaskletPreviewSectionProduct {
    public init() {}
    public func content(name: String, canBeAdded: Bool, addIngredientAction: @escaping () -> Void) -> some View {
        HStack {
            //            VStack() {
            HStack {
                Text(name.capitalizingFirstLetter())
                    .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.subtitleStyle)
                Spacer()
                //                }
                if canBeAdded {
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
                    // Original mockup, has the Blue shopping cart & text
//                    CoursesUButtonStyle(backgroundColor: Color.white, buttonStrokeColor: Color.primaryColor, content: {
//                        HStack {
//                            Image(packageResource: "ShoppingCartIconBlue", ofType: "png")
//                                .resizable()
//                                .foregroundColor(Color.primaryColor)
//                                .frame(width: 20, height: 20)
//                            Text("Ajouter au panier")
//                                .foregroundColor(Color.primaryColor)
//                                .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.subtitleStyle)
                            
//                        }
//                    }, buttonAction: addIngredientAction)
                }
            }
            .padding(Dimension.sharedInstance.lPadding)
            .frame(maxWidth: .infinity)
            //        }
        }
    }
}

@available(iOS 14, *)
struct CoursesUMealPlannerBasketPreviewSectionProduct_Previews: PreviewProvider {
    static var previews: some View {
        CoursesUMealPlannerBasketPreviewSectionProduct().content(name: "Farine de blé", canBeAdded: true,
                                                             addIngredientAction: {})
    }
}
