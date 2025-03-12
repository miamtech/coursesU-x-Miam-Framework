//
//  CoursesUFilterView.swift
//  Pods
//
//  Created by Damien Walerowicz on 12/03/2025.
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
            Text("Affiner ma sélection")
                .coursesUFontStyle(style:
                    CoursesUFontStyleProvider.sharedInstance.titleMediumStyleMulish)
            Spacer()
        }.padding([.top, .leading], 20)
    }
}
