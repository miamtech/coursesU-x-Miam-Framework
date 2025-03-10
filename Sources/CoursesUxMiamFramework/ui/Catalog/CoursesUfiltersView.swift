//
//  CoursesUfiltersView.swift
//  CoursesUxMiamFramework
//
//  Created by Damien Walerowicz on 20/03/2024.
//

import Foundation
import mealzcore
import MealziOSSDK
import SwiftUI

@available(iOS 14.0, *)
public struct CoursesUFilterView: FiltersHeaderProtocol {
    public init() {}
    public func content(params: FiltersHeaderParameters) -> some View {
        HStack {
            Text(Localization.catalog.filtersTitle.localised)
                .coursesUFontStyle(style:
                    CoursesUFontStyleProvider.sharedInstance.titleMediumStyleMulish)
            Spacer()
        }.padding([.top], 20)
    }
}
