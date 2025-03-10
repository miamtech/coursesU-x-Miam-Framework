//
//  CoursesURecipeDetailsUnavailableProductView.swift
//  CoursesUxMiamFramework
//
//  Created by Damien Walerowicz on 02/12/2024.
//

import Foundation
import mealzcore
import MealziOSSDK
import SwiftUI

@available(iOS 14, *)
public struct CoursesURecipeDetailsNowUnavailableProductView: NowUnavailableProductProtocol {
    public init() {}
    let dim = Dimension.sharedInstance
    public func content(params: NowUnavailableProductParameters) -> some View {
        VStack {
            MealzProductBase.ingredientNameAndAmount(
                ingredientName: params.data.ingredientName,
                ingredientUnit: params.data.ingredientUnit,
                ingredientQuantity: params.data.ingredientQuantity,
                isInBasket: false
            )
            VStack {
                HStack {
                    MealzProductBase.productImage(pictureURL: params.data.pictureURL)
                    MealzProductBase.productTitleDescriptionWeight(
                        brand: params.data.brand,
                        name: params.data.name,
                        capacity: params.data.capacity,
                        isSponsored: params.data.isSponsored,
                        pricePerUnitOfMeasurement: params.data.pricePerUnitOfMeasurement,
                        productUnit: params.data.productUnit
                    )
                }
                Spacer()
                HStack(spacing: Dimension.sharedInstance.lPadding) {
                    CoursesUItemSelectorProductRow.productPrice(
                        formattedProductPrice: params.data.formattedProductPrice,
                        discountType: params.data.discountType,
                        discountedPrice: params.data.discountedPrice
                    )
                    Spacer()
                }
                .padding(.horizontal, dim.mlPadding)
            }
            .opacity(0.6)
            MealzProductBase.unavailableTagAndReplaceButton(onReplaceProduct: params.onChangeProduct)
        }
        .frame(height: dim.productHeight)
        .overlay( /// apply a rounded border
            RoundedRectangle(cornerRadius: dim.mCornerRadius)
                .stroke(Color.mealzColor(.lightBackground), lineWidth: 1)
        )
        .padding(.horizontal, dim.mPadding)
    }
}
