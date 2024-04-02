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
public struct CoursesUFavoriteEmptyView: EmptyProtocol {
    public init() {}
    public func content(params: BaseEmptyParameters) -> some View {
        body
    }
    
    public var body: some View {
        VStack(spacing: Dimension.sharedInstance.lPadding) {
            Image(packageResource: "SearchWithCartonIcon", ofType: "png")
                .resizable()
                .frame(width: 100, height: 100)
            Text("Vous n’avez aucune idée repas dans vos favoris.")
                .foregroundColor(Color.white)
                .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.titleMediumStyle)
                .multilineTextAlignment(.center)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.mealzColor(.primary))
    }
}