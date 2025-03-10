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
                Text(params.data.formattedProductPrice)
                    .coursesUFontStyle(style:
                        CoursesUFontStyleProvider.sharedInstance.titleBigStyleMulish)
                    // .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.titleBigStyle)
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
