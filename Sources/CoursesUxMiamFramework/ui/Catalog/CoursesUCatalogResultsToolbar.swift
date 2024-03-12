//
//  CoursesUCatalogResultsToolbar.swift
//
//
//  Created by didi on 08/08/2023.
//

import SwiftUI
import MiamIOSFramework

@available(iOS 14, *)
public struct CoursesUCatalogResultsToolbar: CatalogToolbarProtocol {
    public init () {}
    public func content(params: CatalogToolbarParameters) -> some View {
        VStack(alignment: .leading, spacing: Dimension.sharedInstance.lPadding) {
             HStack(spacing: Dimension.sharedInstance.xlPadding) {
                CatalogToolbarButtonFormat(icon:  Image.mealzIcon(icon: .search), action: params.onSearchTapped)
                Spacer()
                CatalogToolbarButtonFormat(icon:  Image.mealzIcon(icon: .filters), action: params.onFiltersTapped)
                if params.usesPreferences {
                    CatalogToolbarButtonFormat(icon:  Image.mealzIcon(icon: .chefHat), action: params.onPreferencesTapped)
                }
            }.padding([.horizontal, .vertical], Dimension.sharedInstance.lPadding)
        }
    }
}

@available(iOS 14, *)
struct CoursesUCatalogResultsToolbar_Previews: PreviewProvider {
    static var previews: some View {
        CoursesUCatalogToolbar().content(
            params: CatalogToolbarParameters(
            usesPreferences: true,
            onFiltersTapped: {},
            onSearchTapped: {},
            onFavoritesTapped: {},
            onPreferencesTapped: {}))
    }
}
