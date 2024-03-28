//
//  CoursesUItemSelectorNoResultsView.swift
//  abseil
//
//  Created by Damien Walerowicz on 26/03/2024.
//

import SwiftUI
import MiamIOSFramework

@available(iOS 14, *)
public class CoursesUItemSelectorNoResultsView: ItemSelectorNoResultsProtocol {
    public init() {}
    public func content(params: ItemSelectorNoResultsParameters) -> some View {
        VStack {
            Image(packageResource: "SearchWithCartonIconColor", ofType: "png")
                .resizable()
                .scaledToFit()
                .frame(height: 200)
            Text(params.title)
                .foregroundColor(Color.mealzColor(.standardDarkText))
                .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.titleMediumStyle)
            if let subtitle = params.subtitle {
                Text(subtitle)
                    .foregroundColor(Color.mealzColor(.primaryText))
                    .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.subtitleStyle)
            }
        }
    }
}
