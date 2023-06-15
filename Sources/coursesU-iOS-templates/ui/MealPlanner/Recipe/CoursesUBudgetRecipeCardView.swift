//
//  MiamBudgetRecipeCardView.swift
//  MiamIOSFramework
//
//  Created by Vincent Kergonna on 04/05/2023.
//  Copyright © 2023 Miam. All rights reserved.
//

import SwiftUI
import miamCore
import MiamIOSFramework

@available(iOS 14, *)
public struct CoursesUBudgetRecipeCardView<CardTemplate: BudgetRecipeCard,
                                       CardLoadingTemplate: BudgetRecipeCardLoading>: View {
    private let recipeId: String
    private let recipeCardTemplate: CardTemplate
    private let recipeCardLoadingTemplate: CardLoadingTemplate
    private let actions: BudgetRecipeCardActions
    @StateObject var recipeViewModel = RecipeCardVM(routerVM: RouterOutletViewModel())
    public init(recipeId: String, recipeCardTemplate: CardTemplate,
                recipeCardLoadingTemplate: CardLoadingTemplate,
                actions: BudgetRecipeCardActions) {
        self.recipeId = recipeId
        self.recipeCardTemplate = recipeCardTemplate
        self.recipeCardLoadingTemplate = recipeCardLoadingTemplate
        self.actions = actions
    }

    public var body: some View {
        // TODO: replace this!
//        HStack {
//            UIStateWrapperView(uiState: recipeViewModel.state?.recipeState) {
//                recipeCardLoadingTemplate.content()
//            } successView: {
//                if let recipe = recipeViewModel.recipe {
//                    let recipeInfos = RecipeInfos(recipe: recipe,
//                                                  price: Price(price: 34.0, currency: "EUR"),
//                                                  isInBasket: false)
//                    recipeCardTemplate.content(recipeInfos: recipeInfos,
//                                               actions: actions)
//                }
//            }
//        }
//        .onAppear {
//            recipeViewModel.fetchRecipe(recipeId: recipeId, included: nil)
//        }
        let recipeInfos = FakeRecipe().createRandomFakeRecipeInfos()
        recipeCardTemplate.content(
                recipeInfos: recipeInfos,
                actions: actions)
    }
}

@available(iOS 14, *)
struct CoursesUBudgetRecipeCardView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesUBudgetRecipeCardView(recipeId: "9422",
                                 recipeCardTemplate: CoursesUBudgetRecipeCard(),
                                 recipeCardLoadingTemplate: CoursesUBudgetRecipeCardLoading(),
                                     actions: BudgetRecipeCardActions(recipeTapped: {}, removeTapped: nil, replaceTapped: nil))
    }
}
