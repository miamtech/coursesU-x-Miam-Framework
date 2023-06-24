//
//  BudgetPlannerRecipeSearchView.swift
//  MiamIOSFramework
//
//  Created by Vincent Kergonna on 25/05/2023.
//  Copyright © 2023 Miam. All rights reserved.
//

import SwiftUI
import miamCore
import MiamIOSFramework

@available(iOS 14, *)
public struct CoursesUBudgetPlannerRecipePickerView<
    SearchTemplate: BudgetSearch,
    CardTemplate: RecipeCard,
    Footer: BudgetPlannerFooter>: View {
    private let searchTemplate: SearchTemplate
    private let cardTemplate: CardTemplate
    private let stickyFooter: Footer
    private let onRecipeSelected: (String) -> Void
    @StateObject private var viewModel: MealPlannerReplaceRecipeViewModel
        @SwiftUI.State private var searchText = ""
        @SwiftUI.State private var showSearchField = false
        public init(searchTemplate: SearchTemplate,
                    cardTemplate: CardTemplate,
                    stickyFooter: Footer,
                    maxBudget: Double,
                onRecipeSelected: @escaping (String) -> Void) {
        self.searchTemplate = searchTemplate
        self.cardTemplate = cardTemplate
            self.stickyFooter = stickyFooter
        self.onRecipeSelected = onRecipeSelected
            _viewModel = StateObject(wrappedValue: MealPlannerReplaceRecipeViewModel(maxCost: KotlinDouble(value: maxBudget)))
    }

    public var body: some View {
        ZStack(alignment: .top) {
            Color.budgetBackgroundColor
            Image(packageResource: "WhiteWave", ofType: "png")
                .resizable()
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.2)
            VStack {
                searchTemplate.content(searchText: $searchText, filtersTapped: {})
                    .onChange(of: searchText) { newValue in
                        viewModel.search(input: newValue)
                    }
                // TODO: use ui state?
            if viewModel.recipes.isEmpty && searchText != "" {
                    Text("0 idée repas")
                        .coursesUFontStyle(style: CoursesUFontStyleProvider().titleStyle)
                        .padding(.top, 35)
                    NoSearchResults(message: "Désolé, il n'y a pas d'idée repas correspondant à cette recherche.")
                } else {
                    // if results
                    ScrollView {
                        LazyVGrid(columns: [.init(), .init()]) {
                            ForEach(viewModel.recipes, id: \.self) { recipe in
                                CoursesURecipeCardView(
                                    recipe.id,
                                    cardTemplate: cardTemplate,
                                    loadingTemplate: CoursesURecipeCardLoading(),
                                    showDetails: {},
                                    add: {
                                        viewModel.addRecipeToMealPlanner(recipeId: recipe.id, index: 0)
                                        onRecipeSelected(recipe.id)
                                    })
                            }
                        }.padding(Dimension.sharedInstance.lPadding)
                            .padding(.bottom, 100)
                    }
                }
            }
            VStack{
                Spacer()
//                stickyFooter.content(budgetInfos: viewModel.budgetInfos, budgetSpent: viewModel.state?.totalPrice ?? 0, validateTapped: {
                    
//                })
            }
        }
    }
    
    
}

@available(iOS 14, *)
struct CoursesUBudgetPlannerRecipePickerView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesUBudgetPlannerRecipePickerView(
            searchTemplate: CoursesUBudgetSearch(),
            cardTemplate: CoursesURecipeCard(),
            stickyFooter: CoursesUBudgetPlannerFooter(), maxBudget: 23.6,
            onRecipeSelected: { _ in })
    }
}
