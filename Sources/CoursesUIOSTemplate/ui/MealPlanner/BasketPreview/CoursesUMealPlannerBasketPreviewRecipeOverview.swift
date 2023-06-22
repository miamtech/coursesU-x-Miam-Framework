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
            CoursesURecipeCardCoreFrame(
                recipe: basketPreviewInfos.recipe,
                price: basketPreviewInfos.price,
                centerContent: {
                    ArticlesAndPricePerPerson(numberOfProductsInBasket: basketPreviewInfos.numberOfProductsInBasket, pricePerPerson: basketPreviewInfos.pricePerPerson)
            }, callToAction: {
                BasketPreviewCardCallToAction(actions: basketPreviewActions)
            })
        }
    
    @available(iOS 14, *)
    internal struct ArticlesAndPricePerPerson: View {
        var numberOfProductsInBasket: Int
        var pricePerPerson: String
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
                    
                    
                    
                }
                Spacer()
            }
        }
    }

    @available(iOS 14, *)
    internal struct BasketPreviewCardCallToAction: View {
        var actions: BasketPreviewRecipeActions
        @SwiftUI.State private var showContents = false
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
                   
                    actions.delete()
                } label: {
                    Image(packageResource: "TrashIcon", ofType: "png")
                        .resizable()
                        .frame(width: 20, height: 20)
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
        let basketInfos = BasketPreviewInfos(recipe: recipe, price: Price(price: 14.56, currency: "EUR"), pricePerPerson: "12.3", numberOfProductsInBasket: 3)
        ZStack {
            Color.budgetBackgroundColor
            CoursesUMealPlannerBasketPreviewRecipeOverview().content(basketPreviewInfos: basketInfos, basketPreviewActions: BasketPreviewRecipeActions(delete: {}, expand: {}, updateGuests: {_ in}))
            .padding()
        }
    }
}
