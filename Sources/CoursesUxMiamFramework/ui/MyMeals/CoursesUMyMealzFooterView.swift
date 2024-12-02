//
//  CoursesUMyMealzFooterView.swift
//  Pods
//
//  Created by Damien Walerowicz on 02/12/2024.
//
import mealzcore
import MealziOSSDK
import SwiftUI

@available(iOS 14, *)
public struct CoursesUMyMealsFooterView: MyMealsFooterProtocol {
    public init() {}
    let dimension = Dimension.sharedInstance
    public func content(
        params: MyMealsFooterParameters
    ) -> some View {
        VStack {
            Button(action: params.navigateToClientBasket, label: {
                Text(params.text)
                    .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.titleStyle)
                    .padding(dimension.lPadding)
                    .foregroundColor(Color.mealzColor(.white))
            })
            .frame(maxWidth: .infinity)
            .background(Color.mealzColor(.primary))
            .cornerRadius(1000)
        }
        .padding(Dimension.sharedInstance.lPadding)
        .frame(maxWidth: .infinity)
        .background(Color.mealzColor(.white).ignoresSafeArea(edges: .bottom))
    }
}
