//
//  SwiftUIView.swift
//  
//
//  Created by didi on 6/15/23.
//

import SwiftUI
import miamCore
import MiamIOSFramework

@available(iOS 14, *)
public struct CoursesUMealPlannerBasketPreviewRecipeOverview: MealPlannerBasketPreviewRecipeOverview {
   
    
    public init() {}
    public func content(basketPreviewInfos: BasketPreviewInfos, basketPreviewActions: BasketPreviewRecipeActions) -> some View {
        ZStack(alignment: .topTrailing) {
            CoursesURecipeCardCoreFrame(
                recipe: basketPreviewInfos.recipe,
                price: basketPreviewInfos.price,
                centerContent: {
                    ArticlesPriceRecapCounter(
                        numberOfProductsInBasket: basketPreviewInfos.numberOfProductsInBasket,
                        pricePerPerson: basketPreviewInfos.pricePerPerson,
                        price: basketPreviewInfos.price,
                        guests: basketPreviewInfos.guests
                    ) { guestNumber in
                        basketPreviewActions.updateGuests(guestNumber)
                    }
                }, callToAction: {
                    BasketPreviewCardCallToAction(actions: basketPreviewActions)
                })
            .padding(.bottom)
            .onTapGesture {
                basketPreviewActions.onRecipeTapped(basketPreviewInfos.recipe.id)
            }
            if basketPreviewInfos.isReloading {
                ProgressView()
                    .padding(Dimension.sharedInstance.mPadding)
            }
        }
        }
    
    @available(iOS 14, *)
    internal struct ArticlesPriceRecapCounter: View {
        var numberOfProductsInBasket: Int
        var pricePerPerson: String
        var price: Price
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
                            priceAmount:  price.formattedPrice(),
                            trailingText: "",
                            leadingPadding: 0, trailingPadding: 0,
                            textFontStyle: CoursesUFontStyleProvider.sharedInstance.bodySmallStyle,
                            yellowSubtextFontStyle: CoursesUFontStyleProvider.sharedInstance.bodySmallBoldStyle,
                            yellowSubtextWidth: CGFloat(30)
                        )
                        .frame(width: 65)
                        CoursesUStepperWithCallback(
                            count: guests,
                            buttonSize: Dimension.sharedInstance.mlButtonHeight,
                            textFontStyle: CoursesUFontStyleProvider.sharedInstance.bodySmallBoldStyle,
                            textToDisplay: "pers.",
                            subtextFontStyle: CoursesUFontStyleProvider.sharedInstance.bodySmallStyle,
                            onValueChanged: { guestNumber in
                                updateGuests(guestNumber)
                            })
                    }
                    
                }
//                Spacer()
            }
        }
    }

    @available(iOS 14, *)
    internal struct BasketPreviewCardCallToAction: View {
        var actions: BasketPreviewRecipeActions
        @SwiftUI.State private var showContents = false
        @SwiftUI.State private var loading = false
        var body: some View {
            HStack(alignment: .bottom) {
                Button {
                    withAnimation {
                        showContents.toggle()
                        actions.expand()
                    }
                } label: {
                    HStack {
                        //                            Text(Localization.basket.swapProduct.localised)
                        // TODO: localize
                        Text("Voir le détail")
                            .foregroundColor(Color.primaryColor)
                            .coursesUFontStyle(style: CoursesUFontStyleProvider().bodyBigStyle)
                        if showContents {
                            Image(systemName: "chevron.up")
                                .resizable()
                                .foregroundColor(Color.primaryColor)
                                .frame(width: 16, height: 10)
                        } else {
                            Image(systemName: "chevron.down")
                                .resizable()
                                .foregroundColor(Color.primaryColor)
                                .frame(width: 16, height: 10)
                        }
                        
                    }
                }
//                                    if #unavailable(iOS 15) {
                Spacer()
                Button {
                    loading.toggle()
                    actions.delete()
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
//                                    }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, Dimension.sharedInstance.sPadding)
            
        }
    }
}

@available(iOS 14, *)
struct CoursesUMealPlannerBasketPreviewRecipeOverview_Preview: PreviewProvider {
    static var previews: some View {
        
        let recipe = FakeRecipe().createRandomFakeRecipe()
        let basketInfos = BasketPreviewInfos(
            recipe: recipe,
            price: Price(price: 14.56, currency: "EUR"),
            pricePerPerson: "12.3",
            numberOfProductsInBasket: 3,
            guests: 4
            , isReloading: false
        )
        ZStack {
            Color.budgetBackgroundColor
            CoursesUMealPlannerBasketPreviewRecipeOverview().content(basketPreviewInfos: basketInfos, basketPreviewActions: BasketPreviewRecipeActions(delete: {}, expand: {}, updateGuests: {_ in}, onRecipeTapped: {_ in}))
            .padding()
        }
    }
}
