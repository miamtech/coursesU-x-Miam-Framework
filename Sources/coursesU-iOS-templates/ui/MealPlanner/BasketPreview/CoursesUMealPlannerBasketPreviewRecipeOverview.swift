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
struct CoursesUMealPlannerBasketPreviewRecipeOverview: MealPlannerBasketPreviewRecipeOverview {
    func content(basketPreviewInfo: BasketPreviewInfos,
                 basketPreviewActions: BasketPreviewRecipeActions) -> some View {
    
        
            CoursesURecipeCardCoreFrame(
                recipe: basketPreviewInfo.recipe,
                price: basketPreviewInfo.price,
                centerContent: {
                    ArticlesAndPricePerPerson(recipe: basketPreviewInfo.recipe, price: basketPreviewInfo.price.price)
            }, callToAction: {
                BasketPreviewCardCallToAction(actions: basketPreviewActions)
            })
        }
    
    @available(iOS 14, *)
    internal struct ArticlesAndPricePerPerson: View {
        var recipe: Recipe
        var price: Double
        var body: some View {
            HStack {
                VStack(alignment: .leading) {
                    if let numberOfIngredients = recipe.relationships?.ingredients?.data.count {
                        Text("\(numberOfIngredients) articles")
                            .foregroundColor(Color.gray)
                            .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.bodyStyle)
                    }
                    
                    if let numberOfGuests = recipe.attributes?.numberOfGuests {
                        let pricePerPerson = price / Double(numberOfGuests)
                        Text(String(format: "%.2f € / personne", pricePerPerson))
                            .foregroundColor(Color.gray)
                            .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.bodyStyle)
                    }
                    
                    
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
            HStack {
                Button {
                    showContents.toggle()
                    actions.delete()
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
            .padding(.vertical, Dimension.sharedInstance.lPadding)
            
        }
    }
}

@available(iOS 14, *)
struct CoursesUMealPlannerBasketPreviewRecipeOverview_Preview: PreviewProvider {
    static var previews: some View {
        
        let recipe = FakeRecipe().createRandomFakeRecipe()
        let basketInfos = BasketPreviewInfos(recipe: recipe, price: Price(price: 14.56, currency: "EUR"))
        ZStack {
            Color.budgetBackgroundColor
            CoursesUMealPlannerBasketPreviewRecipeOverview().content(basketPreviewInfo: basketInfos, basketPreviewActions: BasketPreviewRecipeActions(delete: {}, expand: {}, updateGuests: {_ in}))
            .padding()
        }
    }
}
