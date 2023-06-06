////
////  SwiftUIView.swift
////  
////
////  Created by didi on 6/6/23.
////
//
//import SwiftUI
//import miamCore
//import MiamIOSFramework
//
//import SwiftUI
//
//@available(iOS 14, *)
//public struct CoursesUBudgetPlannerView<ToolbarTemplate: BudgetPlannerToolbar,
//                                CardTemplate: BudgetRecipeCard,
//                                LoadingCardTemplate: BudgetRecipeCardLoading,
//                                PlaceholderCardTemplate: BudgetRecipePlaceholder>: View {
//    private let toolbarTemplate: ToolbarTemplate
//    private let recipeCardTemplate: CardTemplate
//    private let loadingCardTemplate: LoadingCardTemplate
//    private let placeholderCardTemplate: PlaceholderCardTemplate
//
//    private let onReplaceRecipe: (String) -> Void
//    private let validateRecipes: () -> Void
//
//    @SwiftUI.State private var recipesIds: [String]
//    @SwiftUI.State private var recipeToReplace: String?
//    @SwiftUI.State private var budgetSpent: Double = 10
//    @SwiftUI.State private var isLoadingRecipes = false
//
//    @AppStorage("tech.miam.MealPlannerAmount") private var amount: Double = 30.0
//    @AppStorage("tech.miam.MealPlannerNumberOfGuests") private var numberOfGuests: Int = 4
//    @AppStorage("tech.miam.MealPlannerNumberOfMeals") private var numberOfMeals: Int = 4
//
//    public init(toolbarTemplate: ToolbarTemplate,
//                recipeCardTemplate: CardTemplate,
//                loadingCardTemplate: LoadingCardTemplate,
//                placeholderCardTemplate: PlaceholderCardTemplate,
//                recipes: [String],
//                budgetInfos: BudgetInfos? = nil,
//                validateRecipes: @escaping () -> Void,
//                replaceRecipe: @escaping (String) -> Void) {
//        self._recipesIds = State(initialValue: recipes)
//        self.toolbarTemplate = toolbarTemplate
//        self.recipeCardTemplate = recipeCardTemplate
//        self.loadingCardTemplate = loadingCardTemplate
//        self.placeholderCardTemplate = placeholderCardTemplate
//        self.onReplaceRecipe = replaceRecipe
//        self.validateRecipes = validateRecipes
//        if let budgetInfos {
//            amount = budgetInfos.moneyBudget
//            numberOfGuests = budgetInfos.numberOfGuests
//            numberOfMeals = budgetInfos.numberOfMeals
//        }
//
//        if #unavailable(iOS 16) {
//            UITableView.appearance().backgroundColor = .clear
//        }
//    }
//
//    public var body: some View {
//        VStack {
//            toolbarTemplate.content(budgetInfos: BudgetInfos(moneyBudget: amount,
//                                                             numberOfGuests: numberOfMeals,
//                                                             numberOfMeals: numberOfMeals),
//                                    isLoadingRecipes: $isLoadingRecipes) { infos in
//                // TODO: get new recipes from view model or repository?
//            }
//                                                             .padding(Dimension.sharedInstance.lPadding)
//            let budgetInfos = BudgetInfos(moneyBudget: amount,
//                                          numberOfGuests: numberOfGuests,
//                                          numberOfMeals: numberOfMeals)
//            let budgetPlannerInfos = BudgetPlannerInfos(recipes: recipesIds,
//                                                        budgetInfos: budgetInfos,
//                                                        totalPrice: Price(price: 45.67, currency: "EUR"))
//
////            List {
////                if #available(iOS 15, *) {
////                    recipesListWithSwipeAction()
////                } else {
////                    recipesList()
////                }
////            }
////            .clearListBackground()
////            .background(Color.white)
////            .padding(.horizontal, -15.0)
////
////            MiamBudgetPlannerStickyFooter(budgetSpent: $budgetSpent, totalBudgetPermitted: 40.0) {
////                validateRecipes()
////            }
//        }
//    }
//}
//
//@available(iOS 14, *)
//extension BudgetPlannerView {
//    @available(iOS 15, *)
//    private func recipesListWithSwipeAction() -> some View {
//        ForEach(recipesIds, id: \.self) { recipe in
//            if recipe.isEmpty {
//                placeholderCardTemplate.content {
//                    self.replaceRecipe(recipe)
//                }
//            } else {
//                let actions = BudgetRecipeCardActions(removeTapped: {
//                    removeRecipe(recipe)
//                }, replaceTapped: {
//                    recipeToReplace = recipe
//                    replaceRecipe(recipe)
//                })
//                MiamBudgetRecipeCardView(recipeId: recipe,
//                                         recipeCardTemplate: recipeCardTemplate,
//                                         recipeCardLoadingTemplate: loadingCardTemplate,
//                                         actions: actions)
//                .listRowSeparator(.hidden)
//                .listRowInsets(.init(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0))
//                .swipeActions(edge: .trailing) {
//                    Button {
//                        guard let removeAction = actions.removeTapped else {
//                            return
//                        }
//                        removeAction()
//                    } label: {
//                        VStack {
//                            Image.miamNeutralImage(icon: .bin)
//                                .renderingMode(.template)
//
//                        }.background(Color.miamNeutralColor(.errorBackground))
//                    }
//                    .tint(Color.miamNeutralColor(.errorBackground))
//                }
//            }
//        }
//    }
//
//    @available(iOS 14, *)
//    private func recipesList() -> some View {
//        ForEach(recipesIds, id: \.self) { recipe in
//            if recipe.isEmpty {
//                placeholderCardTemplate.content {
//                    self.replaceRecipe(recipe)
//                }
//            } else {
//                let actions = BudgetRecipeCardActions(removeTapped: {
//                    removeRecipe(recipe)
//                }, replaceTapped: {
//                    recipeToReplace = recipe
//                    replaceRecipe(recipe)
//                })
//                MiamBudgetRecipeCardView(recipeId: recipe,
//                                         recipeCardTemplate: recipeCardTemplate,
//                                         recipeCardLoadingTemplate: loadingCardTemplate,
//                                         actions: actions)
//            }
//        }
//    }
//}
//
//@available(iOS 14, *)
//extension BudgetPlannerView {
//    private func removeRecipe(_ recipeId: String) {
//        guard let index = self.recipesIds.firstIndex(where: { $0 == recipeId }) else {
//            return
//        }
//        self.recipesIds[index] = ""
//    }
//
//    private func replaceRecipe(_ recipeId: String) {
//        self.onReplaceRecipe(recipeId)
//    }
//}
//
////@available(iOS 14, *)
////struct CoursesUBudgetPlannerView_Previews: PreviewProvider {
////    static var previews: some View {
////        CoursesUBudgetPlannerView(
////            toolbarTemplate: MiamBudgetPlannerToolbar(),
////            successTemplate: MiamBudgetPlannerSuccess(), recipesIds: [],
////            budgetInfos: nil)
////    }
////}
