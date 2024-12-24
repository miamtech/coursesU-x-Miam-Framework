//
//  CoursesUOrderedEmptyView.swift
//  abseil
//
//  Created by Damien Walerowicz on 18/12/2024.
//

import mealzcore
import MealziOSSDK
import SwiftUI

@available(iOS 14, *)
public struct CoursesUOrderedEmptyView: EmptyProtocol {
    public init() {}
    public func content(params: BaseEmptyParameters) -> some View {
        VStack(spacing: Dimension.sharedInstance.lPadding) {
            Image(packageResource: "SearchWithCartonIconColor", ofType: "png")
                .resizable()
                .frame(width: 140, height: 140)
            Text(params.text)
                .foregroundColor(Color.mealzColor(.standardDarkText))
                .coursesUFontStyle(
                    style: CoursesUFontStyleProvider.sharedInstance.titleMediumStyle
                )
                .multilineTextAlignment(.center)
                .padding()
            if let cta = params.onOptionalCallback {
                Button(
                    action: cta,
                    label: {
                        Text(Localization.myProducts.noProductCTA.localised)
                            .miamFontStyle(
                                style: MiamFontStyleProvider.sharedInstance.bodyBigBoldStyle
                            )
                            .foregroundColor(Color.mealzColor(.standardLightText))
                    }
                )
                .padding(Dimension.sharedInstance.lPadding)
                .background(Color.mealzColor(.primary))
                .clipShape(Capsule())
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.mealzColor(.white))
    }
}
