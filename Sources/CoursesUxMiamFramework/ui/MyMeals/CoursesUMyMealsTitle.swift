//
//  CoursesUMyMealsTitle.swift
//
//
//  Created by miam x didi on 22/02/2024.
//

import SwiftUI
import mealzcore
import MealziOSSDK

@available(iOS 14, *)
public struct CoursesUMyMealsTitle: BaseTitleProtocol {
    public init() {}
    public func content(params: TitleParameters) -> some View {
        HStack {
            Text(params.title)
                .foregroundColor(Color.mealzColor(.primaryText))
                .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.titleStyle)
        }.frame(maxWidth: .infinity)
    }
}
