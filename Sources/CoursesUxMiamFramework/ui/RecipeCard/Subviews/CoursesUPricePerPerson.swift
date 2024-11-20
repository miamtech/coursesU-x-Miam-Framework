//
//  CoursesUPricePerPerson.swift
//
//
//  Created by miam x didi on 20/02/2024.
//


import Foundation
import SwiftUI
import mealzcore
import MealziOSSDK

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
                .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.titleStyle)
            Text(Localization.myMeals.perPerson.localised)
                .foregroundColor(Color.mealzColor(.grayText))
                .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodyStyle)
        }
    }
}
