//
//  CoursesUMealPlannerRecipePickerNoResults.swift
//
//
//  Created by Diarmuid McGonagle on 06/02/2024.
//

import mealzcore
import MealziOSSDK
import SwiftUI

@available(iOS 14, *)
public struct CoursesUMealPlannerRecipePickerNoResults: CatalogRecipesListNoResultsProtocol {
    public init() {}
    public func content(params: CatalogRecipesListNoResultsParameters) -> some View {
        VStack {
            NoSearchResults(message: Localization.catalog.noRecipeFound.localised)
                .padding(.top, 35)
            Spacer()
        }
    }
}
