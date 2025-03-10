//
//  SwiftUIView.swift
//
//
//  Created by didi on 6/15/23.
//

import mealzcore
import MealziOSSDK
import SwiftUI

@available(iOS 14, *)
public struct CoursesUMealPlannerBasketPreviewRecipeOverview: BasketRecipeOverviewProtocol {
    public init() {}
    public func content(params: BasketRecipeOverviewParameters) -> some View {
        ZStack(alignment: .topTrailing) {
            CoursesURecipeCardCoreFrame(
                recipe: params.data.recipe,
                price: params.data.price,
                centerContent: {
                    ArticlesPriceRecapCounter(
                        numberOfProductsInBasket: params.data.totalProductCount,
                        pricePerPerson: params.data.price.pricePerPersonWithText(numberOfGuests: params.data.guests),
                        price: params.data.price,
                        guests: params.data.guests
                    ) { guestNumber in
                        params.onUpdateGuests(guestNumber)
                    }
                }, callToAction: {
                    BasketPreviewCardCallToAction(onDelete: params.onDeleteRecipe, expand: params.onExpand)
                }, showRecipeDetails: params.onShowRecipeDetails
            )
            .padding(.bottom)
            .onTapGesture {
                params.onShowRecipeDetails(params.data.recipe.id)
            }
            if params.data.isReloading {
                ProgressView()
                    .padding(Dimension.sharedInstance.mPadding)
            }
        }
    }
    
    @available(iOS 14, *)
    struct ArticlesPriceRecapCounter: View {
        var numberOfProductsInBasket: Int
        var pricePerPerson: String
        var price: Double
        var guests: Int
        var updateGuests: (Int) -> Void
        var body: some View {
            HStack {
                VStack(alignment: .leading) {
                    if numberOfProductsInBasket > 0 {
                        Text("\(numberOfProductsInBasket) articles")
                            .foregroundColor(Color.gray)
                            .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.bodyStyle)
                    }
                    Text(pricePerPerson)
                        .foregroundColor(Color.gray)
                        .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.bodyStyle)
                    HStack(spacing: 1) {
                        RecapPriceForRecipes(
                            leadingText: "",
                            priceAmount: price.currencyFormatted,
                            trailingText: "",
                            leadingPadding: 0, trailingPadding: 0,
                            textFontStyle: CoursesUFontStyleProvider.sharedInstance.bodySmallStyleMulish,
                            yellowSubtextFontStyle: CoursesUFontStyleProvider.sharedInstance.bodySmallBoldStyleMulish,
                            yellowSubtextWidth: CGFloat(30)
                        )
                        .frame(width: 65)
                        CoursesUStepperWithCallback(
                            count: guests,
                            buttonSize: Dimension.sharedInstance.mlButtonHeight,
                            textFontStyle: CoursesUFontStyleProvider.sharedInstance.bodySmallBoldStyle,
                            textToDisplay: Localization.myMeals.perPerson.localised,
                            subtextFontStyle: CoursesUFontStyleProvider.sharedInstance.bodySmallStyle,
                            onValueChanged: { guestNumber in
                                updateGuests(guestNumber)
                            }
                        )
                    }
                }
                //                Spacer()
            }
        }
    }
    
    @available(iOS 14, *)
    struct BasketPreviewCardCallToAction: View {
        let onDelete: () -> Void
        let expand: () -> Void
        @SwiftUI.State private var showContents = false
        @SwiftUI.State private var loading = false
        var body: some View {
            HStack(alignment: .bottom) {
                Button {
                    withAnimation {
                        showContents.toggle()
                        expand()
                    }
                } label: {
                    HStack {
                        Text(Localization.recipe.showDetails.localised)
                            .foregroundColor(Color.mealzColor(.primary))
                            .coursesUFontStyle(style: CoursesUFontStyleProvider().bodyBigStyle)
                        if showContents {
                            Image(systemName: "chevron.up")
                                .resizable()
                                .foregroundColor(Color.mealzColor(.primary))
                                .frame(width: 16, height: 10)
                        } else {
                            Image(systemName: "chevron.down")
                                .resizable()
                                .foregroundColor(Color.mealzColor(.primary))
                                .frame(width: 16, height: 10)
                        }
                    }
                }
                Spacer()
                Button {
                    loading.toggle()
                    onDelete()
                } label: {
                    VStack {
                        if loading {
                            ProgressView()
                                .padding(Dimension.sharedInstance.mPadding)
                        } else {
                            Image(packageResource: "TrashIcon", ofType: "png")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                    }.frame(width: 20, height: 20)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.top, Dimension.sharedInstance.sPadding)
        }
    }
}

@available(iOS 14, *)
struct CoursesUMealPlannerBasketPreviewRecipeOverview_Preview: PreviewProvider {
    static var previews: some View {
        let recipe = FakeRecipe().createRandomFakeRecipe()
        let basketData = BasketRecipeData(
            recipe: recipe,
            price: 14.56,
            guests: 3,
            isReloading: false,
            totalProductCount: 4,
            isExpandable: false,
            isExpanded: false
        )
        ZStack {
            Color.budgetBackgroundColor
            CoursesUMealPlannerBasketPreviewRecipeOverview().content(params: BasketRecipeOverviewParameters(
                recipeCardDimensions: CGSize(width: 300, height: 300),
                data: basketData,
                onDeleteRecipe: {},
                onExpand: {},
                onUpdateGuests: { _ in },
                onShowRecipeDetails: { _ in }
            ))
            .padding()
        }
    }
}
