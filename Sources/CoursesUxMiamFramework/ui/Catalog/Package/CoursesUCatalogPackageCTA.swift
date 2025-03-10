//
//  CoursesUCatalogPackageCTA.swift
//
//
//  Created by didi on 11/08/2023.
//

import mealzcore
import MealziOSSDK
import SwiftUI

@available(iOS 14, *)
public struct CoursesUCatalogPackageCTA: CatalogPackageCTAProtocol {
    public init() {}
    public func content(params: CatalogPackageCTAParameters) -> some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(params.title)
                .foregroundColor(Color.mealzColor(.primaryText))
                .coursesUFontStyle(style:
                    CoursesUFontStyleProvider.sharedInstance.titleBigStyleMulish)
            HStack {
                if let subtitle = params.subtitle {
                    Text(subtitle)
                        .foregroundColor(Color.mealzColor(.grayText))
                        .coursesUFontStyle(style:
                            CoursesUFontStyleProvider.sharedInstance.bodyStyleMulish)
                        
                        .lineLimit(1)
                }
                Spacer()
                Button(action: {
                    params.onSeeAllRecipes()
                }, label: {
                    HStack {
                        Text(Localization.catalog.showAll.localised)
                            .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodyBigBoldStyle)
                            .foregroundColor(Color.mealzColor(.primary))
                        Image.mealzIcon(icon: .caret)
                            .renderingMode(.template)
                            .foregroundColor(Color.mealzColor(.primary))
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
