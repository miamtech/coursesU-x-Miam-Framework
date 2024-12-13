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
    public func content(params: FiltersHeaderParameters) -> some View  {
        HStack {
            Button(action: params.onCloseFilters, label: {
                Image.mealzIcon(icon: .arrow)
                    .renderingMode(.template)
                    .rotationEffect(Angle(degrees: 180))
            })
            .frame(width: 40, height: 40)
            .overlay(Circle().stroke(Color.white, lineWidth: 1))
            .foregroundColor(Color.mealzColor(.white))
            .clipShape(Circle()).padding()
            
            Text(Localization.filter.pageTitle.localised)
                .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.titleStyle)
                .foregroundColor(Color.mealzColor(.white))
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.mealzColor(.primary))
    }
    
}
