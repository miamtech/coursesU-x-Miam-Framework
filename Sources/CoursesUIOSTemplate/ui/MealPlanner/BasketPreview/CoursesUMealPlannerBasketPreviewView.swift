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
public struct CoursesUMealPlannerBasketPreviewView<
    LoadingTemplate: MealPlannerBasketPreviewLoading,
    RecipeOverviewTemplate: MealPlannerBasketPreviewRecipeOverview,
    BasketPreviewProduct: MealPlannerBasketPreviewProduct,
    SectionTitleTemplate: MealPlannerBasketPreviewSectionTitle,
    SectionProductTemplate: MealPlannerBaskletPreviewSectionProduct
>: View {
    private let loadingTemplate: LoadingTemplate
    private let recipeOverview: RecipeOverviewTemplate
    private let basketProduct: BasketPreviewProduct
    private let sectionTitleTemplate: SectionTitleTemplate
    private let sectionProductTemplate: SectionProductTemplate
    
    private let validateRecipes: () -> Void
    
    @StateObject var previewViewModel = MealPlannerBasketPreviewVM()
    @SwiftUI.State private var budgetSpent: Double = 50.0
    
    
    public init(
        loadingTemplate: LoadingTemplate,
        recipeOverview: RecipeOverviewTemplate,
        basketProduct: BasketPreviewProduct,
        sectionTitleTemplate: SectionTitleTemplate,
        sectionProductTemplate: SectionProductTemplate,
        validateRecipes: @escaping () -> Void) {
            self.loadingTemplate = loadingTemplate
        self.recipeOverview = recipeOverview
        self.basketProduct = basketProduct
        self.validateRecipes = validateRecipes
        self.sectionTitleTemplate = sectionTitleTemplate
        self.sectionProductTemplate = sectionProductTemplate
    }
    
    public var body: some View {
        ZStack(alignment: .top) {
            Color.budgetBackgroundColor
            Image(packageResource: "WhiteWave", ofType: "png")
                .resizable()
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.2)
            UIStateWrapperView(uiState: previewViewModel.state?.lines) {
                VStack {
                    Spacer()
                    loadingTemplate.content()
                    Spacer()
                }
            } emptyView: {
                VStack {
                    Spacer()
                    NoSearchResults(message: "Vous n'avez aucune recette dans votre panier.")
                    Spacer()
                }
            } successView: {
                successContent()
            }
            footer()
        }
    }
    
    func successContent() -> some View {
            ScrollView {
                    recipesList()
                        .padding(.horizontal, Dimension.sharedInstance.lPadding)
                // only needed if there is a footer,
                Spacer()
                    .frame(height: 100)
                    .listRowBackground(Color.clear)
                    .modifier(removeLines())
                    .listRowInsets(EdgeInsets())
            }
            .listStyle(PlainListStyle())
            .padding(.top, 50)
            
    }
    // may delete this
    func footer() -> some View {
        VStack{
            Spacer()
            CoursesUBudgetPlannerStickyFooter(
                budgetSpent: previewViewModel.totalPrice,
                totalBudgetPermitted: Double(previewViewModel.budget),
                footerContent:
                    Text("Finaliser")
                        .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.titleStyle)
                        .foregroundColor(Color.white)
                        .padding(.horizontal),
                buttonAction: {
                validateRecipes()
            })
        }
    }
    
    @available(iOS 14, *)
    private func recipesList() -> some View {
        ForEach(previewViewModel.meals) { meal in
            MealPlannerBasketPreviewExpandableMealView(
                recipeOverviewTemplate: recipeOverview,
                productTemplate: basketProduct,
                sectionTitleTemplate: sectionTitleTemplate,
                sectionProductTemplate: sectionProductTemplate,
                meal: meal,
                mealViewModel: previewViewModel
            )
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets())
                .padding(.vertical, Dimension.sharedInstance.mPadding)
        }
    }
}


@available(iOS 14, *)
struct CoursesUMealPlannerBasketPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesUMealPlannerBasketPreviewView(
            loadingTemplate: CoursesUMealPlannerBasketPreviewLoading(), recipeOverview: CoursesUMealPlannerBasketPreviewRecipeOverview(),
            basketProduct: CoursesUMealPlannerBasketPreviewProduct(),
            sectionTitleTemplate: CoursesUMealPlannerBasketPreviewSectionTitle(),
            sectionProductTemplate: CoursesUMealPlannerBasketPreviewSectionProduct(),
            validateRecipes: { print("validating")})
    }
}
