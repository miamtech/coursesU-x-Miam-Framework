//
//  CoursesUCatalogToolbar.swift
//
//
//  Created by didi on 08/08/2023.
//

import SwiftUI
import mealzcore
import MealziOSSDK

@available(iOS 14, *)
public struct CoursesUCatalogToolbar: CatalogToolbarProtocol {
    public init () {}
    public func content(params: CatalogToolbarParameters) -> some View {
        VStack(alignment: .leading, spacing: Dimension.sharedInstance.lPadding) {
            HStack {
                Text(Localization.catalog.title.localised)
                    .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.titleBigStyle)
                    .foregroundColor(Color.mealzColor(.white))
                Spacer()
            }
            .padding(Dimension.sharedInstance.lPadding)
            .background(Color.mealzColor(.primary))
            .frame(maxWidth: .infinity)
            HStack(spacing: Dimension.sharedInstance.xlPadding) {
                CatalogToolbarButtonFormat(icon:  Image.mealzIcon(icon: .search), action: params.onSearchTapped)
                Spacer()
                CatalogToolbarButtonFormat(icon:  Image.mealzIcon(icon: .filters), action: params.onFiltersTapped)
                if params.usesPreferences {
                    CatalogToolbarButtonFormat(icon:  Image.mealzIcon(icon: .chefHat), action: params.onPreferencesTapped)
                }
                CatalogToolbarButtonFormat(icon:Image(packageResource: "heart-toolbar", ofType: "png"), action: params.onFavoritesTapped)
            }
            .padding([.horizontal, .bottom], Dimension.sharedInstance.lPadding)
        }
    }
}

@available(iOS 14, *)
struct CatalogToolbarButtonFormat: View {
    let icon: Image
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            icon
                .renderingMode(.template)
                .resizable()
                .frame(width: 25, height: 24)
                .foregroundColor(Color.mealzColor(.primary))
        }
        .frame(width: 30)
    }
}
