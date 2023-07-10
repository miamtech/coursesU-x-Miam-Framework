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
//    @SwiftUI.State private var showContents = false
public func content(title: String, showResults: Binding<Bool>) -> some View {
        Button {
            withAnimation {
                showResults.wrappedValue.toggle()
            }
        } label: {
            HStack {
                Text(title)
                    .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.subtitleStyle)
                Spacer()
                if showResults.wrappedValue {
                    Image(systemName: "chevron.up")
                        .resizable()
                        .foregroundColor(Color.black)
                        .frame(width: 16, height: 10)
                } else {
                    Image(systemName: "chevron.down")
                        .resizable()
                        .foregroundColor(Color.black)
                        .frame(width: 16, height: 10)
                }
            }
        }
        .padding(Dimension.sharedInstance.lPadding)
        .background(Color.lightGray)
        .cornerRadius(Dimension.sharedInstance.sCornerRadius)
        .padding(.horizontal, Dimension.sharedInstance.mPadding)
        .frame(maxWidth: .infinity)
    }
}

@available(iOS 14, *)
struct CoursesUMealPlannerBasketPreviewSectionTitle_Previews: PreviewProvider {
    static var previews: some View {
        CoursesUMealPlannerBasketPreviewSectionTitle().content(title: "Produits indisponibles", showResults: .constant(false)) 
    }
}
