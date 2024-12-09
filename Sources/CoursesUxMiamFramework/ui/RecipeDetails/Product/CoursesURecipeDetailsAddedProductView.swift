//
//  CoursesURecipeDetailsAddedProductView.swift
//
//
//  Created by miam x didi on 22/02/2024.
//

import mealzcore
import MealziOSSDK
import SwiftUI

public let mealzProductHeight: CGFloat = 280

@available(iOS 14, *)
public struct CoursesURecipeDetailsAddedProductView: RecipeDetailsAddedProductProtocol {
    public init() {}
    let dim = Dimension.sharedInstance
    public func content(params: RecipeDetailsAddedProductParameters) -> some View {
        VStack(spacing: 0) {
            MealzProductBase.ingredientNameAndAmount(
                ingredientName: params.data.ingredientName,
                ingredientUnit: params.data.ingredientUnit,
                ingredientQuantity: params.data.ingredientQuantity,
                isInBasket: true)
            Spacer().frame(height: 15)
            HStack {
                MealzProductBase.productImage(pictureURL: params.data.pictureURL)
                MealzProductBase.productTitleDescriptionWeight(
                    brand: params.data.brand,
                    name: params.data.name,
                    capacity: params.data.capacity,
                    isSponsored: params.data.isSponsored,
                    pricePerUnitOfMeasurement: params.pricePerUnitOfMeasurement,
                    productUnit: params.productUnit
                )
            }
            Spacer()
            HStack {
                Text(params.data.formattedProductPrice)
                    .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.titleBigStyle)
                    .padding(.horizontal, 12)
                    .foregroundColor(Color.mealzColor(.primaryText))
                Spacer()
                QuantityCounter(params: params)
            }
            MealzProductBase.ignoreOrReplaceProduct(
                lockButton: params.updatingQuantity,
                onIgnoreProduct: params.onIgnoreProduct,
                onReplaceProduct: params.onChangeProduct
            )
            Spacer()
            MealzProductBase.showNumberOfSharedRecipes(
                numberOfOtherRecipesSharingThisIngredient: params.data.numberOfOtherRecipesSharingThisIngredient)
        }
        .frame(height: mealzProductHeight)
        .clipped()
        .overlay( /// apply a rounded border
            RoundedRectangle(cornerRadius: dim.mCornerRadius)
                .stroke(Color.mealzColor(.primary), lineWidth: 1)
        )
        .padding(.horizontal, dim.mPadding)
    }

    struct QuantityCounter: View {
        let params: RecipeDetailsAddedProductParameters
        let dim = Dimension.sharedInstance
        var body: some View {
            HStack {
                Button {
                    if params.data.productQuantity == 1 {
                        params.onDeleteProduct()
                    } else {
                        params.updateProductQuantity(params.data.productQuantity - 1)
                    }
                } label: {
                    Image.mealzIcon(icon: .minus)
                        .renderingMode(.template)
                        .foregroundColor(Color.mealzColor(.white))
                }
                .disabled(params.updatingQuantity)
                if params.updatingQuantity {
                    ProgressLoader(color: Color.mealzColor(.white), size: 10)
                } else {
                    Text(String(params.data.productQuantity))
                        .frame(minWidth: 10, alignment: .center)
                        .foregroundColor(Color.mealzColor(.white))
                }
                Button {
                    params.updateProductQuantity(params.data.productQuantity + 1)
                } label: {
                    Image.mealzIcon(icon: .plus)
                        .renderingMode(.template)
                        .foregroundColor(Color.mealzColor(.white))
                }
                .disabled(params.updatingQuantity)
            }
            .padding(dim.mPadding)
            .background(Color.mealzColor(.primary))
            .cornerRadius(1000)
            .padding(dim.mPadding)
        }
    }
}
