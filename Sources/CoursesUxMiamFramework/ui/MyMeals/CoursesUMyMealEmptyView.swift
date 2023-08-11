//
//  CoursesUMyMealEmptyView.swift
//  MiamIOSFramework
//
//  Created by Miam on 21/07/2022.
//

import SwiftUI
import MiamIOSFramework

@available(iOS 14, *)
public struct CoursesUMyMealEmptyView: View {
    public init() {}
    let discoverRecipes: () -> Void
    public var body: some View {
        VStack(spacing: Dimension.sharedInstance.lPadding) {
            Image(packageResource: "SearchWithCartonIcon", ofType: "png")
                .resizable()
                .frame(width: 100, height: 100)
            Text("Vous n’avez aucune idée repas dans votre panier.")
                .foregroundColor(Color.white)
                .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.titleMediumStyle)
                .multilineTextAlignment(.center)
            CoursesUButtonStyle(backgroundColor: Color.white, content: {
                Text("Je découvre les recettes")
                    .foregroundColor(Color.primaryColor)
                    .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.bodyStyle)
            }, buttonAction: discoverRecipes)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.primaryColor)
    }
}

@available(iOS 14, *)
struct CoursesUMyMealEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesUMyMealEmptyView(discoverRecipes: {})
    }
}

