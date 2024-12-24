//
//  CoursesUCatalogResultsToolbar.swift
//
//
//  Created by didi on 08/08/2023.
//

import mealzcore
import MealziOSSDK
import SwiftUI

@available(iOS 14, *)
public struct CoursesUCatalogResultsToolbar: CatalogToolbarProtocol {
    public init() {}
    let offsetBeforeChangingViews: CGFloat = 25
    public func content(params: CatalogToolbarParameters) -> some View {
        func determineHeight() -> CGFloat {
            if params.currentElementHeight > params.maximumHeight { return params.maximumHeight }
            else if params.currentElementHeight < params.minimumHeight { return params.minimumHeight }
            else { return params.currentElementHeight }
        }
        return VStack {
            if determineHeight() < params.maximumHeight - offsetBeforeChangingViews {
                MealzCatalogToolbarMinimizedSizeView(params: params, withFavorites: true)
                    .padding(.horizontal, Dimension.sharedInstance.lPadding)
            } else {
                MealzCatalogResultsToolbarFullSizeView(
                    params: params,
                    withFavorites: true)
                Spacer()
            }
        }
        .frame(height: determineHeight())
    }
}

@available(iOS 14, *)
struct MealzCatalogResultsToolbarFullSizeView: View {
    let params: CatalogToolbarParameters
    let withFavorites: Bool

    init(params: CatalogToolbarParameters, withFavorites: Bool) {
        self.params = params
        self.withFavorites = withFavorites
    }

    var body: some View {
        VStack(alignment: .leading, spacing: Dimension.sharedInstance.lPadding) {
            VStack(spacing: 1) {
                if let subtitle = params.subtitle {
                    Text(params.title)
                        .lineLimit(2)
                        .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.titleBigStyle)
                        .padding(.horizontal, Dimension.sharedInstance.mlPadding)
                        .padding(.top, Dimension.sharedInstance.sPadding)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(subtitle)
                        .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodyStyle)
                        .foregroundColor(Color.mealzColor(.grayText))
                        .padding([.top, .horizontal], Dimension.sharedInstance.mlPadding)
                        .frame(maxWidth: .infinity, alignment: .leading)
                } else {
                    Text(params.title)
                        .lineLimit(2)
                        .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.titleBigStyle)
                        .padding([.top, .horizontal], Dimension.sharedInstance.mlPadding)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }.frame(maxWidth: .infinity)
            HStack {
                if params.usesPreferences && !params.isFavorite {
                    MealzCatalogToolbarFullSizeButtonFormat(
                        icon: Image.mealzIcon(icon: .admin),
                        text: Localization.catalog.preferencesTitle.localised,
                        badgeNumber: params.numberOfActivePreferences,
                        action: params.onPreferencesTapped)
                }
                if withFavorites {
                    MealzCatalogToolbarFullSizeButtonFormat(
                        icon: Image(packageResource: "heart-toolbar", ofType: "png"),
                        text: Localization.catalog.favoriteTitle.localised,
                        action: params.onFavoritesTapped)
                }
            }
            .padding(.horizontal, Dimension.sharedInstance.mlPadding)
            Divider().frame(maxWidth: .infinity)
            HStack(spacing: Dimension.sharedInstance.xlPadding) {
                MealzCatalogToolbarButtonFormat(icon: Image.mealzIcon(icon: .search), action: params.onSearchTapped)
                Spacer()
                if !params.isFavorite {
                    MealzCatalogToolbarButtonFormat(
                        icon: Image.mealzIcon(icon: .filters),
                        badgeNumber: params.numberOfActiveFilters,
                        action: params.onFiltersTapped)
                }
            }
            .padding(.horizontal, Dimension.sharedInstance.lPadding)
        }
    }
}
