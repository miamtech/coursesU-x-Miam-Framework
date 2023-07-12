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
    SearchTemplate: MealPlannerSearch,
    CardTemplate: RecipeCard,
    Footer: MealPlannerFooter>: View {
    private let searchTemplate: SearchTemplate
    private let cardTemplate: CardTemplate
    private let stickyFooter: Footer
    /// To add the recipe to the meal planner
    private let onRecipeSelected: (String) -> Void
    /// To show the Recipe Page
    private let onRecipeTapped: (String) -> Void
    @StateObject private var viewModel: MealPlannerReplaceRecipeViewModel
        @SwiftUI.State private var searchText = ""
        @SwiftUI.State private var showSearchField = false
        public init(searchTemplate: SearchTemplate,
                    cardTemplate: CardTemplate,
                    stickyFooter: Footer,
                    maxBudget: Double,
                onRecipeSelected: @escaping (String) -> Void,
                    onRecipeTapped: @escaping (String) -> Void) {
        self.searchTemplate = searchTemplate
        self.cardTemplate = cardTemplate
            self.stickyFooter = stickyFooter
        self.onRecipeSelected = onRecipeSelected
            self.onRecipeTapped = onRecipeTapped
            let guestNumber = UserDefaults.standard.value(forKey: "miam_mealplanner_numberofguests") as? Int ?? 4
            _viewModel = StateObject(wrappedValue: MealPlannerReplaceRecipeViewModel(maxCost: KotlinDouble(value: maxBudget), numberOfGuests: KotlinInt(integerLiteral: guestNumber)))
            print("replace: max is \(maxBudget)")
    }
    @SwiftUI.State private var showingFilters = false
    @SwiftUI.State private var isLoading = false
    @AppStorage("miam_index_of_recipe_replaced") var miamIndexOfRecipeReplaced = 4

    public var body: some View {
        ZStack(alignment: .top) {
            Color.budgetBackgroundColor
            Image(packageResource: "WhiteWave", ofType: "png")
                .resizable()
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.2)
            VStack {
                searchTemplate.content(searchText: $searchText, filtersTapped: {
                    showingFilters.toggle()
                })
                    .onChange(of: searchText) { newValue in
                        isLoading = true
                        viewModel.recipes = []
                        viewModel.search(input: newValue)
                        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
                            isLoading = false
                        }
                    }
                    .sheet(isPresented: $showingFilters) {
                        showingFilters = false
                    } content: {
                        CatalogFiltersView {
                            isLoading = true
                            showingFilters = false
                            viewModel.recipes = []
                            viewModel.search(input: searchText)
                            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
                                isLoading = false
                            }
                        } close: {
                            showingFilters = false
                        }
                    }
                if isLoading {
                    VStack {
                        Spacer()
                        ProgressLoader(color: Color.primaryColor)
                        Spacer()
                    }
                }
                // TODO: use ui state?
           else if viewModel.recipes.isEmpty && searchText != "" {
                    Text("0 idée repas")
                        .coursesUFontStyle(style: CoursesUFontStyleProvider().titleStyle)
                        .padding(.top, 35)
                    NoSearchResults(message: "Désolé, il n'y a pas d'idée repas correspondant à cette recherche.")
                } else {
                    // if results
                    ScrollView {
                        LazyVGrid(columns: [.init(), .init()]) {
                            ForEach(viewModel.recipes.indices, id: \.self) { index in
                                CatalogRecipeCardView(
                                    viewModel.recipes[index].id,
                                    cardTemplate: cardTemplate,
                                    loadingTemplate: CoursesURecipeCardLoading(),
                                    showDetails: onRecipeTapped,
                                    add: { recipe in
                                        viewModel.addRecipeToMealPlanner(recipeId: recipe, index: Int32(miamIndexOfRecipeReplaced))
                                        onRecipeSelected(recipe)
                                    }).onAppear {
                                        if index == viewModel.recipes.count - 1 {
                                            print("replace: loading more")
                                            // last item
                                            viewModel.loadPage()
                                        }
                                    }
                            }
                        }.padding(Dimension.sharedInstance.lPadding)
                            .padding(.bottom, 100)
                    }
                }
            }
        }
    }
}

@available(iOS 14, *)
struct CoursesUBudgetPlannerRecipePickerView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesUBudgetPlannerRecipePickerView(
            searchTemplate: CoursesUMealPlannerSearch(),
            cardTemplate: CoursesURecipeCard(),
            stickyFooter: CoursesUMealPlannerFooter(), maxBudget: 23.6,
            onRecipeSelected: { _ in }, onRecipeTapped: { _ in})
    }
}
