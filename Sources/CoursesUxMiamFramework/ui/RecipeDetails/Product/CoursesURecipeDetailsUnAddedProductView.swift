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
        let lockButton: Bool = params.productStatus == ComponentUiState.locked
            || params.productStatus == ComponentUiState.loading || params.parentRecipeIsReloading
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
                            // .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodySmallBoldStyle)
                            .coursesUFontStyle(style:
                                CoursesUFontStyleProvider.sharedInstance.bodySmallBoldStyleMulish)
                    }
                    Text(params.data.name)
                        .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodySmallStyle)
                    HStack {
                        Text(params.data.discountType.formatDiscountAmount(discountAmount: discountAmount) + " " + Localisation.shared.ingredient.immediateDiscount.localised).foregroundColor(
                            Color.mealzColor(.red)).padding(Dimension.sharedInstance.sPadding)
                    }.frame(maxWidth: .infinity)
                        .padding(.horizontal, Dimension.sharedInstance.mPadding)
                        .border(Color.mealzColor(.red))
                        .cornerRadius(Dimension.sharedInstance.sCornerRadius)
                        .padding(Dimension.sharedInstance.mPadding)
                }
            } else {
                Spacer().frame(height: 15)
            }
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
                CoursesUItemSelectorProductRow.productPrice(
                    formattedProductPrice: params.data.formattedProductPrice, discountType: params.data.discountType
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
                lockButton: lockButton,
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

    @ViewBuilder
    func priceAndAddToCart(
        formattedPrice: String,
        lockButton: Bool,
        addToCart: @escaping () -> Void
    ) -> some View {
        HStack {
            MealzProductBase.productPrice(
                formattedProductPrice: formattedPrice,
                discountType: .undiscounted,
                discountedPrice: nil
            )
            Spacer()
            Button(action: addToCart, label: {
                if lockButton {
                    ProgressLoader(color: .white, size: 20)
                } else {
                    Image.mealzIcon(icon: .basket)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color.mealzColor(.white))
                        .frame(width: 20, height: 20)
                }
            })
            .padding(Dimension.sharedInstance.mlPadding)
            .background(Color.mealzColor(.primary)
                .cornerRadius(1000))
            .frame(width: 48, height: 48)
            .disabled(lockButton)
        }.padding(.horizontal, dim.mlPadding)
    }
}
