//
//  CoursesUCatalogToolbar.swift
//
//
//  Created by didi on 08/08/2023.
//

import mealzcore
import MealziOSSDK
import SwiftUI

@available(iOS 14, *)
public struct CoursesUCatalogToolbar: CatalogToolbarProtocol {
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
                MealzCatalogToolbarFullSizeView(
                    params: params,
                    withFavorites: true)
                Spacer()
            }
        }
        .frame(height: determineHeight())
    }
}

@available(iOS 14, *)
struct MealzCatalogToolbarMinimizedSizeView: View {
    let params: CatalogToolbarParameters
    let withFavorites: Bool

    init(params: CatalogToolbarParameters, withFavorites: Bool) {
        self.params = params
        self.withFavorites = withFavorites
    }

    var body: some View {
        HStack(spacing: Dimension.sharedInstance.xlPadding) {
            MealzCatalogToolbarButtonFormat(icon: Image.mealzIcon(icon: .search), action: params.onSearchTapped)
            Spacer()
            if !params.isFavorite {
                MealzCatalogToolbarButtonFormat(
                    icon: Image.mealzIcon(icon: .filters),
                    badgeNumber: params.numberOfActiveFilters,
                    action: params.onFiltersTapped)
                if params.usesPreferences {
                    MealzCatalogToolbarButtonFormat(
                        icon: Image.mealzIcon(icon: .admin),
                        badgeNumber: params.numberOfActivePreferences,
                        action: params.onPreferencesTapped)
                }
            }
            if withFavorites {
                MealzCatalogToolbarButtonFormat(
                    icon: Image(packageResource: "heart-toolbar", ofType: "png"), action: params.onFavoritesTapped)
            }
        }
    }
}

@available(iOS 14, *)
struct MealzCatalogToolbarFullSizeView: View {
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
                        .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.titleStyle)
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
                        .coursesUFontStyle(style:
                            CoursesUFontStyleProvider.sharedInstance.titleBigStyleMulish)
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

@available(iOS 14, *)
struct MealzCatalogToolbarButtonFormat: View {
    let icon: Image
    let badgeNumber: Int
    let action: () -> Void

    init(icon: Image, badgeNumber: Int = 0, action: @escaping () -> Void) {
        self.icon = icon
        self.badgeNumber = badgeNumber
        self.action = action
    }

    var body: some View {
        Button {
            action()
        } label: {
            icon
                .renderingMode(.template)
                .resizable()
                .frame(width: 25, height: 24)
                .foregroundColor(Color.mealzColor(.standardDarkText))
        }
        .frame(width: 30)
        .overlay(
            ZStack {
                if badgeNumber > 0 {
                    Circle()
                        .fill(Color.mealzColor(.standardDarkText))
                        .frame(width: 20, height: 20)
                        .overlay(
                            Text("\(badgeNumber)")
                                .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodyStyle)
                                .foregroundColor(Color.mealzColor(.standardLightText))
                        )
                        .offset(x: 15, y: -10)
                }
            },
            alignment: .topTrailing)
    }
}

@available(iOS 14, *)
struct MealzCatalogToolbarFullSizeButtonFormat: View {
    let icon: Image
    let text: String
    let badgeNumber: Int
    let action: () -> Void

    init(icon: Image, text: String, badgeNumber: Int = 0, action: @escaping () -> Void) {
        self.icon = icon
        self.text = text
        self.badgeNumber = badgeNumber
        self.action = action
    }

    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: Dimension.sharedInstance.sPadding) {
                icon
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 25, height: 24)
                    .foregroundColor(Color.mealzColor(.standardDarkText))
                Text(text)
                    .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodyStyle)
                    .foregroundColor(Color.mealzColor(.standardDarkText))
                if badgeNumber > 0 {
                    Text(String(badgeNumber))
                        .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodyStyle)
                        .foregroundColor(Color.mealzColor(.standardLightText))
                        .padding(Dimension.sharedInstance.mPadding)
                        .background(Circle().fill(Color.mealzColor(.standardDarkText)))
                }
            }
            .padding(Dimension.sharedInstance.mPadding)
        }
        .frame(height: 45)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: Dimension.sharedInstance.xlCornerRadius)
                .fill(Color.mealzColor(.lightGray))
        )
    }
}
