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
public struct CoursesUBudgetPlannerView<
    ToolbarTemplate: BudgetPlannerToolbar,
    FooterTemplate: BudgetPlannerFooter,
    LoadingTemplate: BudgetPlannerLoading,
    EmptyTemplate: BudgetPlannerEmpty,
    CardTemplate: BudgetRecipeCard,
    LoadingCardTemplate: BudgetRecipeCardLoading,
    PlaceholderCardTemplate: BudgetRecipePlaceholder>: View {
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
    
    @SwiftUI.State private var recipesIds: [String]
    @SwiftUI.State private var recipeToReplace: String?
    @SwiftUI.State private var budgetSpent: Double = 50.0
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
                recipes: [String],
                budgetInfos: BudgetInfos? = nil,
                showRecipe: @escaping (String) -> Void,
                validateRecipes: @escaping () -> Void,
                replaceRecipe: @escaping (String) -> Void) {
        self._recipesIds = State(initialValue: recipes)
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
            formViewModel.setNumberOfMeals(amount: Int32(budgetInfos.numberOfMeals))

        }
        
        if #unavailable(iOS 16) {
            UITableView.appearance().backgroundColor = .clear
        }
    }
    
    @SwiftUI.State var showFormOptions = false
    
    public var body: some View {
       
            UIStateWrapperView(uiState: viewModel.state?.meals) {
                loadingTemplate.content()
            } emptyView: {
                let errorMessage = "Aucune idée repas n’a pu être planifiée pour le budget demandé."
                emptyTemplate.content(bugetInfos: formViewModel.budgetInfos, reason: errorMessage)
            } successView: {
                successContent()
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
            footerTemplate.content(budgetInfos: formViewModel.budgetInfos, budgetSpent: viewModel.state?.totalPrice ?? 0) {
                    viewModel.addRecipesToGroceriesList()
                    validateRecipes()
                }
        }
    }
    
    private func toolbar() -> some View {
        VStack(spacing: -40.0) {
            BudgetBackground()
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
                CoursesUBudgetForm().content(budgetInfos: $formViewModel.budgetInfos, isFetchingRecipes: false, onFormValidated: { infos in
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
                .onChange(of: formViewModel.budgetInfos, perform: { newValue in
                        updateBudget(budgetInfos: newValue)
                    })
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
        formViewModel.setNumberOfMeals(amount: Int32(budgetInfos.numberOfMeals))
    }
}

@available(iOS 14, *)
extension CoursesUBudgetPlannerView {

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
    
//    @available(iOS 15, *)
//    private func recipesListWithSwipeAction() -> some View {
//        ForEach(recipesIds, id: \.self) { recipe in
//            VStack {
//                if recipe.isEmpty {
//                    placeholderCardTemplate.content {
//                        self.replaceRecipe(recipe)
//                    }
//                    .padding(.vertical, Dimension.sharedInstance.sPadding)
//                    .background(Color.budgetBackgroundColor)
//                } else {
//                    let actions = createActions(recipe: recipe)
//                    CoursesUBudgetRecipeCardView(
//                        recipeId: recipe,
//                        recipeCardTemplate: recipeCardTemplate,
//                        recipeCardLoadingTemplate: loadingCardTemplate,
//                        actions: actions)
//                    .swipeActions(edge: .trailing) {
//                        Button {
//                            guard let removeAction = actions.removeTapped else {
//                                return
//                            }
//                            removeAction()
//                        } label: {
//                            VStack {
//                                Image(systemName: "trash")
//                                    .foregroundColor(Color.white)
//                            }.background(Color.red)
//                        }
//                        .tint(Color.red)
//                    }
//                    .padding(.vertical, Dimension.sharedInstance.sPadding)
//                    .background(Color.budgetBackgroundColor)
//                }
//            }
//            .listRowBackground(Color.clear)
//            .listRowSeparator(.hidden)
//            .listRowInsets(EdgeInsets())
//            .padding(.vertical, Dimension.sharedInstance.sPadding)
//        }
//    }
    
    @available(iOS 14, *)
    private func recipesList() -> some View {
        ForEach(viewModel.meals, id: \.self) { meal in
            // I use VStack so i can add same bg & padding to comps
            VStack {
                if let meal {
                    let actions = createActions(recipe: meal.recipeId)
                    CoursesUBudgetRecipeCardView(
                        recipeId: meal.recipeId,
                        recipeCardTemplate: recipeCardTemplate,
                        recipeCardLoadingTemplate: loadingCardTemplate,
                        actions: actions)
                    
                } else {
                    placeholderCardTemplate.content {
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
extension CoursesUBudgetPlannerView {
    private func removeRecipe(_ recipeId: String) {
        viewModel.removeRecipe(recipeId)
    }
    
    private func replaceRecipe(_ recipeId: String) {
        self.onReplaceRecipe(recipeId)
    }
}

@available(iOS 14, *)
struct CoursesUBudgetPlannerView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesUBudgetPlannerView(
            toolbarTemplate: CoursesUBudgetPlannerToolbar(),
            footerTemplate: CoursesUBudgetPlannerFooter(),
            loadingTemplate: MiamBudgetPlannerLoading(),
            emptyTemplate: MiamBudgetPlannerEmpty(),
            recipeCardTemplate: CoursesUBudgetRecipeCard(),
            loadingCardTemplate: CoursesUBudgetRecipeCardLoading(),
            placeholderCardTemplate: CoursesUBudgetRecipePlaceholder(),
            recipes: ["178","124", "134", "135"], showRecipe: {_ in}, validateRecipes: {}, replaceRecipe: {_ in})
    }
}
