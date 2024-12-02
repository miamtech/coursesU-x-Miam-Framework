//
//  CoursesURecipeDetailsUnAddedProductView.swift
//  CoursesUxMiamFramework
//
//  Created by Damien Walerowicz on 27/11/2024.
//

import mealzcore
import MealziOSSDK
import SwiftUI

@available(iOS 14, *)
public struct CoursesURecipeDetailsUnAddedProductView: RecipeDetailsUnaddedProductProtocol {
    public init() {}
    let dim = Dimension.sharedInstance
    public func content(params: RecipeDetailsUnaddedProductParameters) -> some View {
        var lockButton: Bool = params.productStatus == ComponentUiState.locked
            || params.productStatus == ComponentUiState.loading
        VStack {
            MealzProductBase.ingredientNameAndAmount(
                ingredientName: params.data.ingredientName,
                ingredientUnit: params.data.ingredientUnit,
                ingredientQuantity: params.data.ingredientQuantity,
                isInBasket: false
            )
            Spacer().frame(height: 40)
            HStack {
                if let pictureURL = URL(string: params.data.pictureURL) {
                    AsyncImage(url: pictureURL) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                    .frame(width: 72, height: 72)
                    .padding(dim.mPadding)
                } else {
                    Image.mealzIcon(icon: .pan).frame(width: 72, height: 72)
                }
                VStack(alignment: .leading) {
                    if let brand = params.data.brand {
                        Text(brand)
                            .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodySmallBoldStyle)
                    }
                    Text(params.data.name)
                        .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodySmallStyle)
                    HStack {
                        if params.data.isSponsored { MealzSponsoredTag() }
                        IngredientUnitBubble(capacity: params.data.capacity)

                        MealzMyProductsProductCard.showUnitOfMeasurement(
                            pricePerUnitOfMeasurement: params.pricePerUnitOfMeasurement,
                            productUnit: params.productUnit
                        )
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, Dimension.sharedInstance.mlPadding)
                .padding(.top, Dimension.sharedInstance.mPadding)
            }
            Spacer()
            HStack {
                MealzProductBase.productPrice(
                    formattedProductPrice: params.data.formattedProductPrice,
                    higherStickerPrice: nil
                )
                Spacer()

                if lockButton {
                    Button(action: {}, label: {
                        ProgressLoader(color: .white, size: 24)
                    })
                    .padding(Dimension.sharedInstance.mlPadding)
                    .background(Color.mealzColor(.primary))
                    .cornerRadius(1000)
                } else {
                    Button(action: params.onAddProduct, label: {
                        Image.mealzIcon(icon: .basket)
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Color.mealzColor(.white))
                            .frame(width: 20, height: 20)
                            .padding(Dimension.sharedInstance.mlPadding)
                            .background(Color.mealzColor(.primary)
                                .cornerRadius(1000))
                            .frame(width: 48, height: 48)
                    })
                }

            }.padding(.horizontal, dim.mlPadding)

            MealzProductBase.ignoreOrReplaceProduct(
                lockButton: params.productStatus == .locked,
                onIgnoreProduct: params.onIgnoreProduct,
                onReplaceProduct: params.onChooseProduct
            )
            Spacer()
        }
        .frame(height: dim.productHeight)
        .overlay( /// apply a rounded border
            RoundedRectangle(cornerRadius: dim.mCornerRadius)
                .stroke(Color.mealzColor(.lightBackground), lineWidth: 1)
        )
        .padding(.horizontal, dim.mPadding)
    }
}
