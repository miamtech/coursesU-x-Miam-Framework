//
//  SwiftUIView.swift
//
//
//  Created by didi on 6/6/23.
//

import SwiftUI
import miamCore
import MiamIOSFramework

import SwiftUI

@available(iOS 14, *)
public struct CoursesUMealPlannerPlannerView<
    ToolbarTemplate: MealPlannerToolbar,
    FooterTemplate: MealPlannerFooter,
    LoadingTemplate: MealPlannerLoading,
    EmptyTemplate: MealPlannerEmpty,
    CardTemplate: MealPlannerRecipeCard,
    LoadingCardTemplate: MealPlannerRecipeCardLoading,
    PlaceholderCardTemplate: MealPlannerRecipePlaceholder>: View {
    private let toolbarTemplate: ToolbarTemplate
    private let footerTemplate: FooterTemplate
    private let loadingTemplate: LoadingTemplate
    private let emptyTemplate: EmptyTemplate
    private let recipeCardTemplate: CardTemplate
    private let loadingCardTemplate: LoadingCardTemplate
    private let placeholderCardTemplate: PlaceholderCardTemplate
    
    private let onReplaceRecipe: (String) -> Void
    private let showRecipe: (String) -> Void
    private let validateRecipes: () -> Void
    
    @SwiftUI.State private var recipeToReplace: String?
    @SwiftUI.State private var isLoadingRecipes = false
    
    private var budgetInfos: BudgetInfos {
        formViewModel.budgetInfos
    }

    @StateObject private var viewModel = MealPlannerMealsVM()
    @StateObject private var formViewModel = MealPlannerFormVM()
    
    public init(toolbarTemplate: ToolbarTemplate,
                footerTemplate: FooterTemplate,
                loadingTemplate: LoadingTemplate,
                emptyTemplate: EmptyTemplate,
                recipeCardTemplate: CardTemplate,
                loadingCardTemplate: LoadingCardTemplate,
                placeholderCardTemplate: PlaceholderCardTemplate,
                
                budgetInfos: BudgetInfos? = nil,
                showRecipe: @escaping (String) -> Void,
                validateRecipes: @escaping () -> Void,
                replaceRecipe: @escaping (String) -> Void) {
        self.toolbarTemplate = toolbarTemplate
        self.footerTemplate = footerTemplate
        self.loadingTemplate = loadingTemplate
        self.emptyTemplate = emptyTemplate
        self.recipeCardTemplate = recipeCardTemplate
        self.loadingCardTemplate = loadingCardTemplate
        self.placeholderCardTemplate = placeholderCardTemplate
        self.onReplaceRecipe = replaceRecipe
        self.showRecipe = showRecipe
        self.validateRecipes = validateRecipes
        if let budgetInfos {
            formViewModel.setBudget(amount: Int32(budgetInfos.moneyBudget))
            formViewModel.setNumberOfGuests(amount: Int32(budgetInfos.numberOfGuests))
            formViewModel.setNumberOfMeals(mealCount: Int32(budgetInfos.numberOfMeals))

        }
        
        if #unavailable(iOS 16) {
            UITableView.appearance().backgroundColor = .clear
        }
    }
    
    @SwiftUI.State var showFormOptions = false
    
    public var body: some View {
        ZStack {
            Color.budgetBackgroundColor
            UIStateWrapperView(uiState: viewModel.state?.meals) {
                loadingTemplate.content()
            } emptyView: {
                let errorMessage = "Aucune idée repas n’a pu être planifiée pour le budget demandé."
                emptyTemplate.content(bugetInfos: formViewModel.budgetInfos, reason: errorMessage)
            } successView: {
                successContent()
            }
        }
    }
    
    private func successContent() -> some View {
        ZStack {
            Color.budgetBackgroundColor
            ScrollView {
                toolbar()
     
//                if #available(iOS 15, *) {
//                    recipesListWithSwipeAction()
//                        .padding(.horizontal, Dimension.sharedInstance.lPadding)
//                } else {
                    recipesList()
                        .padding(.horizontal, Dimension.sharedInstance.lPadding)
//                }
                Spacer()
                    .frame(height: 100)
                    .listRowBackground(Color.clear)
                    .modifier(removeLines())
                    .listRowInsets(EdgeInsets())
            }
    
            footer()
        }
    }
    
    private func footer() -> some View {
        VStack{
            Spacer()
            footerTemplate.content(budgetInfos: formViewModel.budgetInfos, budgetSpent: $viewModel.totalPrice) {
                    viewModel.addRecipesToGroceriesList()
                    validateRecipes()
                }
        }
    }
    
    private func toolbar() -> some View {
        VStack(spacing: -40.0) {
            MealPlannerBackground()
            if !showFormOptions {
                toolbarTemplate.content(
                    budgetInfos: $formViewModel.budgetInfos,
                    isLoadingRecipes: $isLoadingRecipes) { infos in
                        // TODO: get new recipes from view model or repository?
                    }
                    .onTapGesture {
                        withAnimation {
                            showFormOptions.toggle()
                        }
                        
                        print("hello world")
                    }
                    .padding(Dimension.sharedInstance.lPadding)
            } else {
                CoursesUMealPlannerForm(includeTitle: false, includeLogo: false, includeBackground: false).content(budgetInfos: $formViewModel.budgetInfos, isFetchingRecipes: false, onFormValidated: { infos in
                    withAnimation {
                        showFormOptions.toggle()
                        // TODO: need to cause update to other VM here
                        formViewModel.getRecipesForBudgetConstraint(
                            budget: Int32(formViewModel.budgetInfos.moneyBudget),
                            mealCount: Int32(formViewModel.budgetInfos.numberOfMeals),
                            guestCount: Int32(formViewModel.budgetInfos.numberOfGuests)) { recipes, error in
                                isLoadingRecipes.toggle()
                                guard error == nil else {
                                    return
                                }
                                guard let recipes else {
                                    return
                                }
                            }
                    }
                    print("close")
                })
                .onChange(of: formViewModel.budgetInfos) { newMealPlannerInfos in
                    updateBudget(budgetInfos: newMealPlannerInfos)
                }
                // TODO: check w Tibo changes to make sure the app does not crash at certain values
                .onChange(of: combinedMealPlannerAndGuestsCount) { newMealPlannerInfos in
                    if (formViewModel.budgetInfos.moneyBudget > 0.0 && formViewModel.budgetInfos.numberOfGuests > 0) {
                        formViewModel.getRecipesMaxCountForBudgetConstraint(budget: Int32(formViewModel.budgetInfos.moneyBudget), guestCount: Int32(formViewModel.budgetInfos.numberOfGuests))
                        updateMealPlannerWithMax(budgetInfos: formViewModel.budgetInfos)
                    }
                }
                .padding(Dimension.sharedInstance.lPadding)
            }
        }
        .background(Color.budgetBackgroundColor)
        .listRowBackground(Color.clear)
        .modifier(removeLines())
        .listRowInsets(EdgeInsets())
    }
    
    private func updateBudget(budgetInfos: BudgetInfos) {
        formViewModel.setBudget(amount: Int32(budgetInfos.moneyBudget))
        formViewModel.setNumberOfGuests(amount: Int32(budgetInfos.numberOfGuests))
        formViewModel.setNumberOfMeals(mealCount: Int32(budgetInfos.numberOfMeals))
    }
    private func updateMealPlannerWithMax(budgetInfos: BudgetInfos) {
        formViewModel.setBudget(amount: Int32(budgetInfos.moneyBudget))
        formViewModel.setNumberOfGuests(amount: Int32(budgetInfos.numberOfGuests))
        formViewModel.setNumberOfMeals(mealCount: Int32(budgetInfos.maxRecipesForBudget))
    }
    var combinedMealPlannerAndGuestsCount: Int {
        formViewModel.budgetInfos.numberOfGuests + Int(formViewModel.budgetInfos.moneyBudget)
        }
}

@available(iOS 14, *)
extension CoursesUMealPlannerPlannerView {

    func createActions(recipe: String) -> BudgetRecipeCardActions {
        return BudgetRecipeCardActions(recipeTapped: {
            showRecipe(recipe)
        }, removeTapped: {
            
            removeRecipe(recipe)
        }, replaceTapped: {
            recipeToReplace = recipe
            replaceRecipe(recipe)
        })
    }
    @available(iOS 14, *)
    private func recipesList() -> some View {
//        ForEach(viewModel.meals, id: \.self) { meal in
        ForEach(Array(viewModel.meals.enumerated()), id: \.1.self) { index, meal in
            // I use VStack so i can add same bg & padding to comps
            VStack {
                if let meal {
                    let actions = createActions(recipe: meal.recipeId)
                    MealPlannerRecipeCardView(
                        recipeId: meal.recipeId,
                        price: Price(price: meal.price, currency: "EUR"),
                        recipeCardTemplate: recipeCardTemplate,
                        recipeCardLoadingTemplate: loadingCardTemplate,
                        actions: actions)
                    
                } else {
                    placeholderCardTemplate.content {
                        print("index is " + String(index))
//                        miam_index_of_recipe_replaced = index
                        self.replaceRecipe("")
                    }
                }
            }
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets())
            .padding(.vertical, Dimension.sharedInstance.mPadding)
        }
    }
}


@available(iOS 14, *)
extension CoursesUMealPlannerPlannerView {
    private func removeRecipe(_ recipeId: String) {
        viewModel.removeRecipe(recipeId)
    }
    
    private func replaceRecipe(_ recipeId: String) {
        self.onReplaceRecipe(recipeId)
    }
}

@available(iOS 14, *)
struct CoursesUMealPlannerPlannerView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesUMealPlannerPlannerView(
            toolbarTemplate: CoursesUMealPlannerToolbar(),
            footerTemplate: CoursesUMealPlannerFooter(),
            loadingTemplate: MiamBudgetPlannerLoading(),
            emptyTemplate: MiamBudgetPlannerEmpty(),
            recipeCardTemplate: CoursesUMealPlannerRecipeCard(),
            loadingCardTemplate: CoursesUMealPlannerRecipeCardLoading(),
            placeholderCardTemplate: CoursesUMealPlannerRecipePlaceholder(),
           showRecipe: {_ in}, validateRecipes: {}, replaceRecipe: {_ in})
    }
}
