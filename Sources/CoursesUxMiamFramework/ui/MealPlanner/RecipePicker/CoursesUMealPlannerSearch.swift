//
//  MiamBudgetSearch.swift
//  MiamIOSFramework
//
//  Created by Vincent Kergonna on 26/04/2023.
//  Copyright © 2023 Miam. All rights reserved.
//

import mealzcore
import MealziOSSDK
import SwiftUI

@available(iOS 14, *)
public struct CoursesUMealPlannerSearch: SearchProtocol {
    public init() {}
    let dimension = Dimension.sharedInstance
    public func content(params: SearchParameters) -> some View {
        VStack(spacing: 0) {
            HStack(spacing: dimension.mPadding) {
                HStack(spacing: dimension.lPadding) {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .foregroundColor(Color.gray)
                        .frame(width: 20, height: 20)
                    TextField(
                        Localization.myBudget.searchForRecipe.localised,
                        text: params.searchText,
                        onCommit: {}
                    )
                    .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.bodyMediumBoldStyleMulish)
                    .foregroundColor(Color.gray)
                    .frame(maxWidth: .infinity)
                    .autocorrectionDisabled(true)
                    .overlay(
                        HStack {
                            Spacer()
                            if !params.searchText.wrappedValue.isEmpty {
                                Button(action: {
                                    params.searchText.wrappedValue = ""
                                }) {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(.gray)
                                        .frame(width: 20, height: 20)
                                }
                            }
                        }
                    )
                }
                .padding(dimension.mPadding)

                Divider()
                    .foregroundColor(Color.lightGray)
                Button {
                    params.onApply()
                } label: {
                    Image(packageResource: "FiltersIcon", ofType: "png")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .padding(.horizontal, dimension.mPadding)
                }
            }
            .padding(.horizontal, dimension.mPadding)
            .background(Color.white)
            .frame(height: 65)
            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(Color.lightGray)
        }
    }
}

@available(iOS 14, *)
struct CoursesUMealPlannerSearch_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.budgetBackgroundColor
            BudgetSearchWrapper()
        }
    }

    struct BudgetSearchWrapper: View {
        @SwiftUI.State var text = ""

        var body: some View {
            VStack {
                CoursesUMealPlannerSearch()
                    .content(params: SearchParameters(searchText: $text, onApply: {}))
            }
        }
    }
}
