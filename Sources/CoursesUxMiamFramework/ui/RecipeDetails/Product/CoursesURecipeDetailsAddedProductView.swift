//
//  CoursesURecipeDetailsAddedProductView.swift
//
//
//  Created by miam x didi on 22/02/2024.
//

import mealzcore
import MealziOSSDK
import SwiftUI

public let mealzProductHeight: CGFloat = 230

@available(iOS 14, *)
public struct CoursesURecipeDetailsAddedProductView: RecipeDetailsAddedProductProtocol {
    public init() {}
    let dim = Dimension.sharedInstance
    public func content(params: RecipeDetailsAddedProductParameters) -> some View {
        VStack(spacing: 0) {
            HStack {
                Text(params.data.ingredientName.capitalizingFirstLetter())
                    .padding(dim.mPadding)
                    .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodyBigBoldStyle)
                Spacer()
                if let unit = params.data.ingredientUnit {
                    Text(QuantityFormatter.companion.readableFloatNumber(value: params.data.ingredientQuantity, unit: unit))
                        .padding(dim.mPadding)
                        .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodyMediumStyle)
                }
            }
            .foregroundColor(Color.mealzColor(.white))
            .frame(height: 40)
            .background(Color.mealzColor(.primary))
            .cornerRadius(dim.mCornerRadius, corners: .top)
            HStack {
                if let pictureURL = URL(string: params.data.pictureURL) {
                    AsyncImage(url: pictureURL) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                    .frame(width: 72, height: 72)
                    .padding(dim.mPadding)
                }

                VStack(alignment: .leading) {
                    if let brand = params.data.brand {
                        Text(brand)
                            .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodySmallBoldStyle)
                    }
                    Text(params.data.name)
                        .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodySmallStyle)
                    HStack {
                        IngredientUnitBubble(capacity: params.data.capacity)
                        if params.data.isSponsored {
                            MealzSponsoredTag()
                        }
                    }
                    Button(action: params.onChangeProduct, label: {
                        Text(Localization.basket.swapProduct.localised)
                            .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodyMediumBoldStyle)
                            .foregroundColor(Color.mealzColor(.primary))
                    })
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, dim.mlPadding)
                .padding(.top, dim.mPadding)
            }
            if params.data.numberOfOtherRecipesSharingThisIngredient < 2 {
                Spacer()
            }
            HStack {
                Text(params.data.formattedProductPrice)
                    .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.titleBigStyle)
                    .padding(.horizontal, 12)
                    .foregroundColor(Color.mealzColor(.primaryText))
                Spacer()
                QuantityCounter(params: params)
            }
            if params.data.numberOfOtherRecipesSharingThisIngredient > 1 {
                Spacer()
                HStack(alignment: .center) {
                    Text(
                        String(format: String.localizedStringWithFormat(
                            Localization.myProductsProduct.productsSharedRecipe(
                                numberOfProducts: Int32(params.data.numberOfOtherRecipesSharingThisIngredient)
                            ).localised,
                            params.data.numberOfOtherRecipesSharingThisIngredient
                        ),
                        params.data.numberOfOtherRecipesSharingThisIngredient)
                    )
                    .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodySmallStyle)
                    .padding(.vertical, Dimension.sharedInstance.mPadding)
                    .foregroundColor(Color.mealzColor(.grayText))
                }
                .frame(maxWidth: .infinity)
                .background(Color.mealzColor(.lightBackground))
            }
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
            }
            .padding(dim.mPadding)
            .background(Color.mealzColor(.primary))
            .cornerRadius(dim.buttonCornerRadius)
            .padding(dim.mPadding)
        }
    }
}
