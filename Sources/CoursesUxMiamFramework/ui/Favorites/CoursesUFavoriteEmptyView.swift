//
//  CoursesUMyMealEmptyView.swift
//  MiamIOSFramework
//
//  Created by Miam on 21/07/2022.
//

import SwiftUI
import MiamIOSFramework
import MealzUIModuleIOS
import miamCore


@available(iOS 14, *)
public struct CoursesUCatalogFavoriteEmptyView: CatalogRecipesListNoResultsProtocol {
    public init() {}
    public func content(params: CatalogRecipesListNoResultsParameters) -> some View {
        if params.catalogContent == CatalogContent.favorite {
            return AnyView(CoursesUNoFavoritesEmptyView())
        }
        return AnyView(MealzCatalogRecipesListNoResults().content(params: params))
        
    }
}

@available(iOS 14, *)
public struct CoursesUFavoriteEmptyView: EmptyProtocol {
    public init() {}
    public func content(params: BaseEmptyParameters) -> some View {
        CoursesUNoFavoritesEmptyView()
    }
    
    
}


@available(iOS 14, *)
public struct CoursesUNoFavoritesEmptyView: View {
    public var body: some View {
        VStack(spacing: Dimension.sharedInstance.lPadding) {
            Image(packageResource: "SearchWithCartonIcon", ofType: "png")
                .resizable()
                .frame(width: 100, height: 100)
            Text("Vous n’avez aucune idées repas.")
                .foregroundColor(Color.white)
                .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.titleMediumStyle)
                .multilineTextAlignment(.center)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.mealzColor(.primary))
    }
}
