//
//  CoursesUFiltersCTA.swift
//  CoursesUxMiamFramework
//
//  Created by didi on 06/12/2024.
//

import SwiftUI
import MealziOSSDK

@available(iOS 14, *)
public struct CoursesUFiltersCTA: FiltersCTAProtocol {
    public init() {}
    public func content(params: FiltersCTAParameters) -> some View {
        var applyButtonText: String {
            return String(format: String.localizedStringWithFormat(
                Localization.catalog.showResults(numberOfResults: Int32(params.numberOfRecipes)).localised,
                params.numberOfRecipes),
                        params.numberOfRecipes)
        }
        return VStack(spacing: 0) {
            Button(action: params.onApply, label: {
                Text(applyButtonText)
                    .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodyBigStyle)
                    .foregroundColor(.white)
            })
            .padding(Dimension.sharedInstance.lPadding)
            .frame(maxWidth: .infinity)
            .background(Color.mealzColor(.primary))
            .clipShape(RoundedRectangle(cornerRadius: Dimension.sharedInstance.buttonCornerRadius))
            Button(action: params.onClear, label: {
                Text(Localization.catalog.removeFilters.localised)
                    .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodyBigStyle)
                    .foregroundColor(Color.mealzColor(.primary))
            })
            .padding(Dimension.sharedInstance.mPadding)
        }
        .padding(Dimension.sharedInstance.lPadding)
        .frame(maxWidth: .infinity)
        .frame(height: 110)
        .background(Color.white)
        .clipShape(RoundedCorner(radius: 16, corners: [.top]))
        .shadow(color: .lightGray, radius: 5).mask(Rectangle().padding(.top, -20))
    }
}
