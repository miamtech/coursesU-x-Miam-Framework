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
    ProductTemplate: MealPlannerBasketPreviewProduct,
    SectionTitleTemplate: MealPlannerBasketPreviewSectionTitle,
    SectionProductTemplate: MealPlannerBaskletPreviewSectionProduct
>: View {
    private let loadingTemplate: LoadingTemplate
    private let recipeOverviewTemplate: RecipeOverviewTemplate
    private let productTemplate: ProductTemplate
    private let sectionTitleTemplate: SectionTitleTemplate
    private let sectionProductTemplate: SectionProductTemplate
    /// To show the final Recap page
    private let validateRecipes: () -> Void
    /// To replace one of the items in recipe
    private let replaceProduct: (String) -> Void
    /// To show the Recipe Page
    private let onRecipeTapped: (String) -> Void
    
    @StateObject private var previewViewModel = MealPlannerBasketPreviewVM()
    
    public init(
        loadingTemplate: LoadingTemplate,
        recipeOverviewTemplate: RecipeOverviewTemplate,
        productTemplate: ProductTemplate,
        sectionTitleTemplate: SectionTitleTemplate,
        sectionProductTemplate: SectionProductTemplate,
        validateRecipes: @escaping () -> Void,
        replaceProduct: @escaping (String) -> Void,
        onRecipeTapped: @escaping (String) -> Void
    ) {
            self.loadingTemplate = loadingTemplate
        self.recipeOverviewTemplate = recipeOverviewTemplate
        self.productTemplate = productTemplate
        self.validateRecipes = validateRecipes
            self.replaceProduct = replaceProduct
        self.sectionTitleTemplate = sectionTitleTemplate
        self.sectionProductTemplate = sectionProductTemplate
        self.onRecipeTapped = onRecipeTapped
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
            
        }
    }
    
    func successContent() -> some View {
        ZStack {
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
            footer()
        }
            
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
                    .foregroundColor(Color.white)
                        .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.titleStyle)
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
                recipeOverviewTemplate: recipeOverviewTemplate,
                productTemplate: productTemplate,
                sectionTitleTemplate: sectionTitleTemplate,
                sectionProductTemplate: sectionProductTemplate,
                meal: meal,
                replaceProduct: self.replaceProduct,
                onRecipeTapped: self.onRecipeTapped,
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
            loadingTemplate: CoursesUMealPlannerBasketPreviewLoading(), recipeOverviewTemplate: CoursesUMealPlannerBasketPreviewRecipeOverview(),
            productTemplate: CoursesUMealPlannerBasketPreviewProduct(),
            sectionTitleTemplate: CoursesUMealPlannerBasketPreviewSectionTitle(),
            sectionProductTemplate: CoursesUMealPlannerBasketPreviewSectionProduct(),
            validateRecipes: { print("validating")}, replaceProduct: {_ in}, onRecipeTapped: {_ in})
    }
}
