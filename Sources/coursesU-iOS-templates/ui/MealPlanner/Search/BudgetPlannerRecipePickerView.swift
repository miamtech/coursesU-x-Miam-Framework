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
    Footer: View>: View {
    private let searchTemplate: SearchTemplate
    private let cardTemplate: CardTemplate
    private let stickyFooter: Footer
    private let onRecipeSelected: (String) -> Void
//    @StateObject private var viewModel: MealPlannerReplaceRecipeViewModel
    private let recipes = ["134", "135", "136", "137", "138", "139", "140", "141", "142", "143"]
    @SwiftUI.State private var searchText = ""
    @SwiftUI.State private var showSearchField = false
    public init(searchTemplate: SearchTemplate, cardTemplate: CardTemplate, stickyFooter: Footer,
                onRecipeSelected: @escaping (String) -> Void) {
        self.searchTemplate = searchTemplate
        self.cardTemplate = cardTemplate
        self.onRecipeSelected = onRecipeSelected
        self.stickyFooter = stickyFooter
//        _viewModel = StateObject(wrappedValue: MealPlannerReplaceRecipeViewModel(maxCost: 10.0))
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
                        print(newValue)
                    }
                ScrollView {
                    LazyVGrid(columns: [.init(), .init()]) {
                        ForEach(recipes, id: \.self) { recipe in
                            CoursesURecipeCardView(
                                recipe,
                                cardTemplate: cardTemplate,
                                loadingTemplate: CoursesURecipeCardLoading(),
                                showDetails: {},
                                add: {
                                print("Add recipe: \(recipe)")
                                // Either update from the view model, or update in the previous view?
                                onRecipeSelected(recipe)
                            })
                        }
                    }.padding(Dimension.sharedInstance.lPadding)
                        .padding(.bottom, 100)
                }
            }
            VStack{
                Spacer()
                stickyFooter
            }
        }
    }
}

@available(iOS 14, *)
struct CoursesUBudgetPlannerRecipePickerView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesUBudgetPlannerRecipePickerView(
            searchTemplate: CoursesUBudgetSearch(),
            cardTemplate: CoursesURecipeCard(), stickyFooter: CoursesUBudgetPlannerStickyFooter(budgetSpent: .constant(32.0), totalBudgetPermitted: 23.0, buttonAction: {}),
            onRecipeSelected: { _ in })
    }
}
