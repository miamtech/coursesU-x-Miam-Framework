//
//  File.swift
//  
//
//  Created by miam x didi on 20/02/2024.
//

import SwiftUI
import miamCore
import MealzUIModuleIOS
import MiamIOSFramework

@available(iOS 14, *)
public struct CoursesUMealPlannerRecipeDetailsFooterView: RecipeDetailsFooterProtocol {
    public init() {}
    public func content(params: RecipeDetailsFooterParameters) -> some View {
        CoursesURecipeDetailsFooterCore(
            params: params,
            cookOnlyContent:
                CookOnlyModeFooter(pricePerGuest: params.totalPriceOfProductsAddedPerGuest)
        )
    }
    
    internal struct CookOnlyModeFooter: View {
        private let pricePerGuest: Double
        init(pricePerGuest: Double) {
            self.pricePerGuest = pricePerGuest
        }
        var body: some View {
            HStack {
                Spacer()
                CoursesUPricePerPerson(pricePerGuest: pricePerGuest)
                Spacer()
            }
        }
    }
}
