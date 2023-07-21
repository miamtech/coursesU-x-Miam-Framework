//
//  SwiftUIView.swift
//  
//
//  Created by didi on 6/13/23.
//

import SwiftUI
import miamCore
import MiamIOSFramework


@available(iOS 14, *)
public struct CoursesUMealPlannerRecapView: MealPlannerRecap {
    var onClose: () -> Void
    public init(onClose: @escaping () -> Void) {
        self.onClose = onClose
    }
    let dimension = Dimension.sharedInstance
    public func content(numberOfMeals: Int, totalPrice: Price, onTapGesture: @escaping () -> Void) -> some View {
            ZStack(alignment: .top) {
                Color.budgetBackgroundColor
                CoursesUTwoMealsBackground()
                VStack(spacing: -40.0) {
                    MealPlannerBackground()
                    VStack(spacing: 25) {
                        VStack {
                            HStack {
                                Spacer()
                                Button(action: {
                                    onClose()
                                }, label: {
                                    Image(packageResource: "CloseXIcon", ofType: "png")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .padding(5)
                                        .overlay(Circle().stroke(Color.primaryColor, lineWidth: 2))
                                })
                            }
                            Image(packageResource: "GreenCheckmarkIcon", ofType: "png")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                        Text("Les produits associés ont bien été ajoutés au panier")
                            .multilineTextAlignment(.center)
                            .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.titleBigStyle)
                        RecapPriceForRecipes(
                            leadingText: "\(String(numberOfMeals)) repas pour",
                            priceAmount:  totalPrice.formattedPrice(),
                            trailingText: "",
                            textFontStyle: CoursesUFontStyleProvider.sharedInstance.bodyBigStyle,
                            yellowSubtextFontStyle: CoursesUFontStyleProvider.sharedInstance.titleStyle,
                            yellowSubtextWidth: CGFloat(60))
                            
                        
                        Divider()
                        Text("Découvrez aussi :")
                            .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.titleBigStyle)
                        Button(action: {
                            onTapGesture()
                                }) {
                                    Text("Nos promotions")
                                        .foregroundColor(.white)
                                        .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.bodyBigBoldStyle)
                                        .padding(dimension.lPadding)
                                }
                                .background(Color.red)
                                .cornerRadius(50)  // Making the corner radius large for pill-shaped button
                                .buttonStyle(PlainButtonStyle())
                    }
                    .padding(25)
                    .background(Color.white)
                    .cornerRadius(Dimension.sharedInstance.mCornerRadius)
                    .overlay(
                        RoundedRectangle(cornerRadius: Dimension.sharedInstance.mCornerRadius)
                            .stroke(Color.gray, lineWidth: 0.5)
                    )
                    .padding(.horizontal, dimension.lPadding)
                }
            }
        }
}

//@available(iOS 14, *)
//struct CoursesUMealPlannerRecapView_Previews: PreviewProvider {
//    static var previews: some View {
//        CoursesUMealPlannerRecapView().content(onTapGesture: {print("hello")})
//    }
//}
