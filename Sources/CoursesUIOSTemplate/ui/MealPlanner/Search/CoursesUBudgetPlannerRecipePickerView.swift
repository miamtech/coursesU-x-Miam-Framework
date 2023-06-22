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
    private let recipes = ["134", "135", "136", "137", "138", "139", "140", "141", "142", "143"]
    @SwiftUI.State private var searchText = ""
    @SwiftUI.State private var showSearchField = false
    
    // TODO: most likely remove these -> need to know if we need footer or not
    @StateObject private var viewModel = MealPlannerMealsVM()
    @StateObject private var formViewModel = MealPlannerFormVM()
    
    public init(searchTemplate: SearchTemplate, cardTemplate: CardTemplate, stickyFooter: Footer,
                onRecipeSelected: @escaping (String) -> Void) {
        self.searchTemplate = searchTemplate
        self.cardTemplate = cardTemplate
        self.onRecipeSelected = onRecipeSelected
        self.stickyFooter = stickyFooter
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
                // if results
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
//                else
//                Text("0 idée repas")
//                    .coursesUFontStyle(style: CoursesUFontStyleProvider().titleStyle)
//                    .padding(.top, 35)
//                NoSearchResults()
            }
            VStack{
                Spacer()
                stickyFooter.content(budgetInfos: formViewModel.budgetInfos, budgetSpent: viewModel.state?.totalPrice ?? 0, validateTapped: {
                    
                })
            }
        }
    }
    
    struct NoSearchResults: View {
        var body: some View {
            HStack {
                Image(systemName: "exclamationmark")
                    .resizable()
                    .foregroundColor(Color.danger)
                    .frame(width: 5, height: 25)
                    .padding(.trailing, Dimension.sharedInstance.lPadding)
                Text("Désolé, il n'y a pas d'idée repas correspondant à cette recherche.")
                    .coursesUFontStyle(style: CoursesUFontStyleProvider().bodyBigStyle)
            }
            .padding(.vertical, Dimension.sharedInstance.lPadding)
            .padding(.horizontal, Dimension.sharedInstance.xlPadding)
            .background(Color.dangerBackground)
            .cornerRadius(Dimension.sharedInstance.mCornerRadius)
        }
    }
}

@available(iOS 14, *)
struct CoursesUBudgetPlannerRecipePickerView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesUBudgetPlannerRecipePickerView(
            searchTemplate: CoursesUBudgetSearch(),
            cardTemplate: CoursesURecipeCard(),
            stickyFooter: CoursesUBudgetPlannerFooter(),
            onRecipeSelected: { _ in })
    }
}
