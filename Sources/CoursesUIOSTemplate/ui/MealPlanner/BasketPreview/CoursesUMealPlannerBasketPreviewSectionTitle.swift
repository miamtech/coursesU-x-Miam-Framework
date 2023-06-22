//
//  SwiftUIView.swift
//  
//
//  Created by didi on 6/22/23.
//

import SwiftUI
import miamCore
import MiamIOSFramework

@available(iOS 14, *)
public struct CoursesUMealPlannerBasketPreviewSectionTitle: MealPlannerBasketPreviewSectionTitle {
    public init() {}
    public func content(title: String) -> some View {
        VStack(spacing: Dimension.sharedInstance.lPadding) {
            HStack {
                Text(title)
                    .foregroundColor(Color.gray)
                    .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.subtitleStyle)
                Spacer()
            }
            Text("Indisponible")
                .foregroundColor(Color.gray)
                .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.subtitleStyle)
        }
        .padding(Dimension.sharedInstance.lPadding)
        .frame(maxWidth: .infinity)
    }
}

@available(iOS 14, *)
struct CoursesUMealPlannerBasketPreviewSectionTitle_Previews: PreviewProvider {
    static var previews: some View {
        CoursesUMealPlannerBasketPreviewSectionTitle().content(title: "Produits indisponibles")
    }
}
