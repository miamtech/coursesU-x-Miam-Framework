//
//  CoursesUCatalogPackageCTA.swift
//
//
//  Created by didi on 11/08/2023.
//

import SwiftUI
import MiamIOSFramework

@available(iOS 14, *)
public struct CoursesUCatalogPackageCTA: CatalogPackageCTAProtocol {
    public init () {}
    public func content(params: CatalogPackageCTAParameters) -> some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(params.title)
                .foregroundColor(Color.mealzColor(.primaryText))
                .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.titleBigStyle)
            HStack {
                if let subtitle = params.subtitle {
                    Text(subtitle)
                        .foregroundColor(Color.mealzColor(.grayText))
                        .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodyStyle)
                        .lineLimit(1)
                }
                Spacer()
                Button( action: {
                    params.onSeeAllRecipes()
                }, label: {
                    HStack {
                        Text(Localization.catalog.showAll.localised)
                            .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodyBigBoldStyle)
                            .foregroundColor(Color.primaryColor)
                        Image.mealzIcon(icon: .caret)
                            .renderingMode(.template)
                            .foregroundColor(Color.primaryColor)
                    }
                })
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, Dimension.sharedInstance.lPadding)
        .padding(.horizontal, Dimension.sharedInstance.mPadding)
    }
}

@available(iOS 14, *)
struct CoursesUCatalogPackageCTA_Previews: PreviewProvider {
    static var previews: some View {
        CoursesUCatalogPackageCTA().content(
            params: CatalogPackageCTAParameters(
                title: "test",
                subtitle: "test 1",
                onSeeAllRecipes: {}
            ))
    }
}
