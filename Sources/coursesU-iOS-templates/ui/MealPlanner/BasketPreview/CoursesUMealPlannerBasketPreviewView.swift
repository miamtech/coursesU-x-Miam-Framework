//
//  SwiftUIView.swift
//  
//
//  Created by didi on 6/19/23.
//

import SwiftUI
import MiamIOSFramework
import miamCore


@available(iOS 14, *)
struct CoursesUMealPlannerBasketPreviewView: View {
    
    @SwiftUI.State private var budgetSpent: Double = 50.0
    @StateObject private var formViewModel = MealPlannerFormVM()
    @SwiftUI.State private var recipes = FakeRecipe().createListOfRandomRecipeInfos()
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.budgetBackgroundColor
            Image(packageResource: "WhiteWave", ofType: "png")
                .resizable()
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.2)
            List {
                
              
                    recipesList()
                        .padding(.horizontal, Dimension.sharedInstance.lPadding)
                        
                
                Spacer()
                    .frame(height: 100)
                    .listRowBackground(Color.clear)
                    .modifier(removeLines())
                    .listRowInsets(EdgeInsets())
            }
            .listStyle(PlainListStyle())
            .padding(.top, 50)
            VStack{
                Spacer()
                CoursesUBudgetPlannerStickyFooter(
                    budgetSpent: $budgetSpent,
                    totalBudgetPermitted: formViewModel.budgetInfos.moneyBudget,
                    footerContent:
                        Text("Finaliser")
                            .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.titleStyle)
                            .foregroundColor(Color.white)
                            .padding(.horizontal),
                    buttonAction: {
                    print("hello")
                })
            }
        }
    }
    
    @available(iOS 14, *)
    private func recipesList() -> some View {
        ForEach(recipes, id: \.self) { recipe in
            // I use VStack so i can add same bg & padding to comps
            VStack {
//                if recipe.isEmpty {
//                    placeholderCardTemplate.content {
//                        self.replaceRecipe(recipe)
//                    }
//                } else {
//                    let actions = createActions(recipe: recipe)
                CoursesUMealPlannerBasketPreviewRecipeOverview().content(basketPreviewInfo: BasketPreviewInfos(recipe: recipe.recipe, price: recipe.price), basketPreviewActions: BasketPreviewRecipeActions(delete: {}, expand: {}, updateGuests: {_ in}))
//                }
            }
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets())
            .padding(.vertical, Dimension.sharedInstance.mPadding)
        }
    }
}


@available(iOS 14, *)
struct CoursesUMealPlannerBasketPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesUMealPlannerBasketPreviewView()
    }
}
