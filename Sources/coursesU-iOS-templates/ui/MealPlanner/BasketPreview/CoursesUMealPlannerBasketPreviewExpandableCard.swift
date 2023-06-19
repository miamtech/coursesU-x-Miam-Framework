//
//  SwiftUIView.swift
//  
//
//  Created by didi on 6/19/23.
//

import SwiftUI

import miamCore
import MiamIOSFramework

@available(iOS 14, *)
struct CoursesUMealPlannerBasketPreviewExpandableCard:
    View {
    var recipeInfos: MiamIOSFramework.RecipeInfos
   
    var products: [MealPlannerBasketPreviewProductInfos]
    @SwiftUI.State var showProducts = false
    
    
    var body: some View {
        VStack {
            CoursesUMealPlannerBasketPreviewRecipeOverview().content(basketPreviewInfo: BasketPreviewInfos(recipe: recipeInfos.recipe, price: recipeInfos.price), basketPreviewActions: BasketPreviewRecipeActions(delete: {}, expand: {
                withAnimation {
                    showProducts.toggle()
                }
                
            }, updateGuests: {_ in}))
            .animation(nil)
            if showProducts {
                productsList()
                    .animation(Animation.spring())
            }
//            Spacer()
        }
        .background(showProducts ? Color.white : Color.clear)
    }
    
    @available(iOS 14, *)
    private func productsList() -> some View {
//        ForEach(products, id: \.self) { product in
        ForEach(products) { product in
            // I use VStack so i can add same bg & padding to comps
            CoursesUMealPlannerBasketPreviewProduct().content(quantity: .constant(product.sharedRecipeCount), productInfo: product, actions: MealPlannerBudgetPreviewProductActions(delete: {}, changeProduct: {}))
        }
        .transition(.opacity)
    }
}

@available(iOS 14, *)
struct CoursesUMealPlannerBasketPreviewExpandableCard_Previews: PreviewProvider {
    static var previews: some View {
        @SwiftUI.State var products =
        FakeMealPlannerBasketPreviewProductInfos()
        .createListOfRandomInfos()
        var recipes = FakeRecipe().createListOfRandomRecipeInfos()
        CoursesUMealPlannerBasketPreviewExpandableCard(recipeInfos: recipes.first!, products: products)
        
        ScrollView {
            CoursesUMealPlannerBasketPreviewExpandableCard(recipeInfos: recipes.first!, products: products)
            Spacer()
        }
    }
}
