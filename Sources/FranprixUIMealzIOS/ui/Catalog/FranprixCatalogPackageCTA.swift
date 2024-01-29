//
//  FranprixCatalogPackageCTA.swift
//
//
//  Created by Diarmuid McGonagle on 29/01/2024.
//

import SwiftUI
import MiamIOSFramework

@available(iOS 14, *)
public struct FranprixCatalogPackageCTA: CatalogPackageCTAProtocol {
    public init () {}
    public func content(params: CatalogPackageCTAParameters) -> some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading) {
                Text(params.title)
                //                    .font(.lexend(.bold, 16))
                    .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.titleBigStyle)
                //                    .lineLimit(1)
                //                if let subtitle = params.subtitle {
                //                    Text(subtitle)
                //                        .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodyStyle)
                //                        .lineLimit(1)
                //                }
            }
            Spacer()
            Button( action: {
                params.onSeeAllRecipes()
            }, label: {
                Text(Localization.catalog.showAll.localised)
                    .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodyBigBoldStyle)
                //                        .font(.lexend(.semiBold, 16))
                    .foregroundColor(Color.mealzColor(.primary))
            })
        }
        .padding(.horizontal, 16.0)
    }
}

@available(iOS 14, *)
struct FranprixCatalogPackageCTA_Previews: PreviewProvider {
    static var previews: some View {
        FranprixCatalogPackageCTA().content(
            params: CatalogPackageCTAParameters(
                title: "test",
                subtitle: "test 1",
                onSeeAllRecipes: {}
            ))
    }
}
