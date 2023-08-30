//
//  SwiftUIView.swift
//
//
//  Created by didi on 6/6/23.
//

import SwiftUI
import miamCore
import MiamIOSFramework

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
    @SwiftUI.State private var replacingRecipe = false
    
    private var budgetInfos: BudgetInfos {
        formViewModel.budgetInfos
    }

    @StateObject private var viewModel = MealPlannerMealsVM()
    @StateObject private var formViewModel = MealPlannerFormVM()
    let uuid = UUID()

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
        print("stateMgmt: CoursesUMealPlannerPlannerView init \(uuid)")
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
    @SwiftUI.State var activelyUpdatingTextField = false
    @AppStorage("miam_index_of_recipe_replaced") var miamIndexOfRecipeReplaced = 4
    @AppStorage("miam_budget_remaining") var miamBudgetRemaining = 4.0

    let dimension = Dimension.sharedInstance
    
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
            .onAppear {
                print("stateMgmt: CoursesUMealPlannerPlannerView onAppearead \(uuid)")
            }
            .onDisappear {
                formViewModel.detach()
            }
        }
    }
    
    private func getRecipesFromVM() {
        isLoadingRecipes = true
        formViewModel.getRecipesForBudgetConstraint(
            budget: Int32(formViewModel.budgetInfos.moneyBudget),
            mealCount: Int32(formViewModel.budgetInfos.numberOfMeals),
            guestCount: Int32(formViewModel.budgetInfos.numberOfGuests)) { recipes, error in
                isLoadingRecipes = false
                guard error == nil else {
                    return
                }
            }
    }
    
    private func successContent() -> some View {
        let numberOfMealsInBasket = viewModel.meals.compactMap { $0 }.count
        return ZStack {
            Color.budgetBackgroundColor
            if #available(iOS 15.0, *) {
                ScrollView {
                    toolbar()
                    if formViewModel.errorAppeared {
                        NoSearchResults(message: "Aucune idée repas n’a pu être planifiée pour le budget demandé.")
                    } else {
                        Text("\(numberOfMealsInBasket) \(numberOfMealsInBasket == 1 ? "idée repas pour votre budget :" : "idées repas pour votre budget :")")
                            .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.subtitleStyle)
                    }
                    recipesList()
                        .padding(.horizontal, dimension.lPadding)
                    Spacer()
                        .frame(height: 100)
                        .listRowBackground(Color.clear)
                        .modifier(removeLines())
                        .listRowInsets(EdgeInsets())
                }.refreshable {
                    getRecipesFromVM()
                }
            } else {
                ScrollView {
                    toolbar()
                    Text("\(numberOfMealsInBasket) \(numberOfMealsInBasket == 1 ? "idée repas pour votre budget :" : "idées repas pour votre budget :")")
                        .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.subtitleStyle)
                    recipesList()
                        .padding(.horizontal, dimension.lPadding)
                    Spacer()
                        .frame(height: 100)
                        .listRowBackground(Color.clear)
                        .modifier(removeLines())
                        .listRowInsets(EdgeInsets())
                }
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
        VStack(spacing: -50.0) {
            MealPlannerBackground()
            if !showFormOptions {
                toolbarTemplate.content(
                    budgetInfos: $formViewModel.budgetInfos,
                    isLoadingRecipes: $isLoadingRecipes) { infos in
                        // This is empty because the toolbar on CoursesU does nothing, just activates the form dropdown
                    }
                    .onTapGesture {
                        withAnimation {
                            showFormOptions.toggle()
                        }
                        fetchAndUpdateMaxMeals()
                    }
                    .padding(dimension.lPadding)
            } else {
                CoursesUMealPlannerForm(
                    includeTitle: false,
                    includeLogo: false,
                    includeBackground: false
                ).content(
                    budgetInfos: $formViewModel.budgetInfos,
                    activelyUpdatingTextField: $activelyUpdatingTextField,
                    isFetchingRecipes: false,
                    onFormValidated: { infos in
                    withAnimation {
                        replacingRecipe = true
                        showFormOptions.toggle()
                        getRecipesFromVM()
                    }
                })
                .onChange(of: formViewModel.budgetInfos) { newMealPlannerInfos in
                    updateBudget(budgetInfos: newMealPlannerInfos)
                }
                .onChange(of: combinedMealPlannerAndGuestsCount) { newMealPlannerInfos in
                    fetchAndUpdateMaxMeals()
                }
                .padding(dimension.lPadding)
            }
        }
        .background(Color.budgetBackgroundColor)
        .listRowBackground(Color.clear)
        .modifier(removeLines())
        .listRowInsets(EdgeInsets())
    }
    
    private func fetchAndUpdateMaxMeals() {
        if formViewModel.budgetInfos.moneyBudget > 0.0 && formViewModel.budgetInfos.numberOfGuests > 0 {
            formViewModel.getRecipesMaxCountForBudgetConstraint(budget: Int32(formViewModel.budgetInfos.moneyBudget), guestCount: Int32(formViewModel.budgetInfos.numberOfGuests))
//            updateMealPlannerWithMax(budgetInfos: formViewModel.budgetInfos)
            updateBudget(budgetInfos: formViewModel.budgetInfos)
        }
    }
    
    private func updateBudget(budgetInfos: BudgetInfos) {
        formViewModel.setBudget(amount: Int32(budgetInfos.moneyBudget))
        formViewModel.setNumberOfGuests(amount: Int32(budgetInfos.numberOfGuests))
        formViewModel.setNumberOfMeals(mealCount: Int32(budgetInfos.numberOfMeals))
    }
//    private func updateMealPlannerWithMax(budgetInfos: BudgetInfos) {
//        formViewModel.setBudget(amount: Int32(budgetInfos.moneyBudget))
//        formViewModel.setNumberOfGuests(amount: Int32(budgetInfos.numberOfGuests))
//        formViewModel.setNumberOfMeals(mealCount: Int32(budgetInfos.maxRecipesForBudget))
//    }
    var combinedMealPlannerAndGuestsCount: Int {
        formViewModel.budgetInfos.numberOfGuests + Int(formViewModel.budgetInfos.moneyBudget)
    }
}

@available(iOS 14, *)
extension CoursesUMealPlannerPlannerView {
    @available(iOS 14, *)
    private func recipesList() -> some View {
        VStack {
            if !isLoadingRecipes {
                /* PMs on our side insisted that when all recipes are empty & the user taps one, the replacement recipe will go to the placeholder they tapped. Because of this, we sort on the left side of the meals enumerated array: (ex:
                 [0, meal1]
                 [1, nil]
                 [2, meal3]
                 This leads to issues when meals are replaced, as SwiftUI ForEach does not when meal1 is replaced with meal4, because the index is the same. To handle this, we wrap the content in the isLoadingRecipes & have a small wait before setting isLoadingRecipes to false again after a user has replaced a recipe. This is not an ideal solution.
                 if you'd like to have the ForEach depend on the meals, just change the id to 'id: \.1'
                 */
                ForEach(Array(viewModel.meals.enumerated()), id: \.0) { index, meal in
                    // I use VStack so i can add same bg & padding to comps
                    VStack {
                        if let meal {
                            let actions = BudgetRecipeCardActions(recipeTapped: { recipe in
                                showRecipe(recipe)
                            }, removeTapped: {
                                removeRecipe(meal.recipeId)
                            }, replaceTapped: {
                                replacingRecipe = true
                                recipeToReplace = meal.recipeId
                                miamIndexOfRecipeReplaced = index
                                if let totalPrice = viewModel.state?.totalPrice {
                                    viewModel.calculAvailableBudgetOnNavigateToReplaceRecipe(
                                        totalPrice: totalPrice,
                                        recipeToReplacePrice: KotlinDouble(value: meal.price))
                                }
                                replaceRecipe(meal.recipeId)
                            })
                            MealPlannerRecipeCardView(
                                recipeId: meal.recipeId,
                                price: Price(price: meal.price, currency: "EUR"),
                                recipeCardTemplate: recipeCardTemplate,
                                recipeCardLoadingTemplate: loadingCardTemplate,
                                actions: actions)
                        } else {
                            placeholderCardTemplate.content {
                                miamIndexOfRecipeReplaced = index
                                if let totalPrice = viewModel.state?.totalPrice {
                                    viewModel.calculAvailableBudgetOnNavigateToReplaceRecipe(
                                        totalPrice: totalPrice,
                                        recipeToReplacePrice: nil)
                                }
                                self.replaceRecipe("")
                            }
                        }
                    }
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
                    .padding(.vertical, dimension.mPadding)
                }
            }
            else {
                Spacer()
                    .frame(height: 100.0)
                ProgressLoader(color: .primaryColor)
            }
        }
        .onChange(of: viewModel.meals) { newValue in
            if replacingRecipe {
                isLoadingRecipes = true
                replacingRecipe = false
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(600), execute: {
                    isLoadingRecipes = false
                })
            }
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
