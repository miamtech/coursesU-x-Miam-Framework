//
//  CoursesUMyMealEmptyView.swift
//  MiamIOSFramework
//
//  Created by Miam on 21/07/2022.
//

import SwiftUI
import MiamIOSFramework

@available(iOS 14, *)

@available(iOS 14, *)
public struct CoursesUMyMealEmptyView: EmptyProtocol {
    public init() {}
    public func content(params: BaseEmptyParameters) -> some View {
        VStack(spacing: Dimension.sharedInstance.lPadding) {
            Image(packageResource: "SearchWithCartonIcon", ofType: "png")
                    .resizable()
                .frame(width: 100, height: 100)
            Text("Vous n’avez aucune idées repas.")
                .foregroundColor(Color.white)
                .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.titleMediumStyle)
                .multilineTextAlignment(.center)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.mealzColor(.primary))
    }
}
