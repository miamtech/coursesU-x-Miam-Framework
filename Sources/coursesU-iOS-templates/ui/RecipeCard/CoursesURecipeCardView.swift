//
//  CatalogRecipeCardView.swift
//  MiamIOSFramework
//
//  Created by Vincent Kergonna on 26/05/2023.
//  Copyright © 2023 Miam. All rights reserved.
//

import SwiftUI
import miamCore
import MiamIOSFramework

@available(iOS 14, *)
public struct CoursesURecipeCardView<CardTemplate: RecipeCard,
                             LoadingTemplate: RecipeCardLoading>: View {
    private let recipeId: String
    private let cardTemplate: CardTemplate
    private let loadingTemplate: LoadingTemplate
    private let add: () -> Void
    private let show: () -> Void
    @StateObject var recipeViewModel = RecipeCardVM(routerVM: RouterOutletViewModel())

    public init(_ recipeId: String, cardTemplate: CardTemplate,
                loadingTemplate: LoadingTemplate, showDetails: @escaping () -> Void,
                add: @escaping () -> Void) {
        self.cardTemplate = cardTemplate
        self.loadingTemplate = loadingTemplate
        self.add = add
        self.show = showDetails
        self.recipeId = recipeId
    }

    public var body: some View {
        // TODO: put this back!
        //        UIStateWrapperView(uiState: recipeViewModel.state?.recipeState) {
        //            loadingTemplate.content()
        //        } successView: {
        //            if let recipe = recipeViewModel.recipe {
        //                let recipeInfos = RecipeInfos(recipe: recipe,
        //                                              price: Price(price: 34.0, currency: "EUR"),
        //                                              isInBasket: false)
        //                cardTemplate.content(recipeInfos: recipeInfos, actions: RecipeCardActions(like: {},
        //                                                                                          addToBasket: add,
        //                                                                                          showDetails: show))
        //            }
        //        }
        //        .onAppear {
        //            recipeViewModel.fetchRecipe(recipeId: recipeId, included: nil)
        //        }
        //    }
        let recipe = RecipeFakeFactory().create(
            id: RecipeFakeFactory().FAKE_ID,
            attributes: RecipeFakeFactory().createAttributes(title: "Parmentier de Poulet",
            mediaUrl: "https://picsum.photos/500/500"),
            relationships: nil)
            let recipeInfos = RecipeInfos(
                recipe: recipe,
                price: Price(price: 34.0, currency: "EUR"),
                isInBasket: false)
            cardTemplate.content(
                recipeInfos: recipeInfos,
                actions: RecipeCardActions(
                    like: {}, addToBasket: add, showDetails: show))
        
    }
}

@available(iOS 14, *)
struct CoursesURecipeCardView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesURecipeCardView("134", cardTemplate: CoursesURecipeCard(), loadingTemplate: CoursesURecipeCardLoading(),
                              showDetails: {}, add: {})
    }
}
