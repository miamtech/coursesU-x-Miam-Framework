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
                Text("hello world")
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
    internal struct RecipeCardCallToAction: View {
        var actions: BudgetRecipeCardActions
        var body: some View {
            HStack {
                Button {
                    guard let replaceTapped = actions.replaceTapped else {
                        return
                    }
                    replaceTapped()
                } label: {
                    HStack {
                        Image(packageResource: "ReloadIcon", ofType: "png")
                            .resizable()
                            .frame(width: 20, height: 20)
                        //                            Text(Localization.basket.swapProduct.localised)
                        // TODO: localize
                        Text("Changer")
                            .foregroundColor(Color.primaryColor)
                            .coursesUFontStyle(style: CoursesUFontStyleProvider().bodyBigStyle)
                    }
                }
                                    if #unavailable(iOS 15) {
                Spacer()
                Button {
                    guard let removeTapped = actions.removeTapped else {
                        return
                    }
                    removeTapped()
                } label: {
                    Image(packageResource: "TrashIcon", ofType: "png")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                                    }
            }
            .frame(maxWidth: .infinity)
            
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
