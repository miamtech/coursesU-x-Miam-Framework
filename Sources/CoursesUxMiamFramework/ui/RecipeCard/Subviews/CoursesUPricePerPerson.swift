//
//  CoursesUPricePerPerson.swift
//
//
//  Created by miam x didi on 20/02/2024.
//

import Foundation
import mealzcore
import MealziOSSDK
import SwiftUI

@available(iOS 14, *)
public struct CoursesUPricePerPerson: View {
    let pricePerGuest: Double
    public init(pricePerGuest: Double) {
        self.pricePerGuest = pricePerGuest
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            Text(pricePerGuest.currencyFormatted)
                .foregroundColor(Color.mealzColor(.primaryText))
                // .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.titleStyle)
                .coursesUFontStyle(style:
                    CoursesUFontStyleProvider.sharedInstance.titleStyleMulish)
            Text(Localization.myMeals.perPerson.localised)
                .foregroundColor(Color.mealzColor(.grayText))
//                .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodyStyle)
                .coursesUFontStyle(style:
                    CoursesUFontStyleProvider.sharedInstance.bodyStyleMulish)
        }
    }
}
