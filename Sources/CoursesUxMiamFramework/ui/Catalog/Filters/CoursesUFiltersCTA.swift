//
//  CoursesUFiltersCTA.swift
//  CoursesUxMiamFramework
//
//  Created by didi on 06/12/2024.
//

import MealziOSSDK
import SwiftUI

@available(iOS 14, *)
public struct CoursesUFiltersCTA: FiltersCTAProtocol {
    public init() {}
    public func content(params: FiltersCTAParameters) -> some View {
        return VStack(spacing: 0) {
            Button(action: params.onApply, label: {
                Text(Localization.preferences.apply.localised)
                    .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodyBigStyle)
                    .foregroundColor(.white)
            })
            .padding(Dimension.sharedInstance.lPadding)
            .frame(maxWidth: .infinity)
            .background(Color.mealzColor(.primary))
            .clipShape(RoundedRectangle(cornerRadius: Dimension.sharedInstance.buttonCornerRadius))
            Button(action: params.onClear, label: {
                Text(Localization.preferences.reset.localised)
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
