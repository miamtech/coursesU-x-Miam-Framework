//
//  SwiftUIView.swift
//  
//
//  Created by didi on 6/19/23.
//

import SwiftUI
import miamCore
import MiamIOSFramework

@available(iOS 14, *)
struct CoursesURecipeDetailsFooter: View {
    var pricePerPerson: Double
    var priceForMeal: String
    let dimension = Dimension.sharedInstance
    var body: some View {
        HStack {
           
            Text("\(String(format: "%.2f", pricePerPerson))€")
                .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.titleStyle)
            Text("par personne")
                .foregroundColor(Color.gray)
                .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.bodySmallStyle)
            Spacer()
          
                RecapPriceForRecipes(leadingText: "Soit", priceAmount: priceForMeal)
            
                .frame(width: 200)
            
        }
        .frame(maxWidth: .infinity)
        .frame(height: 90)
        .padding(.horizontal, dimension.lPadding)
        .background(Color.white)
        .cornerRadius(dimension.lCornerRadius, corners: [.top])
    }
}



@available(iOS 14, *)
struct CoursesURecipeDetailsFooter_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.budgetBackgroundColor
            VStack {
                CoursesURecipeDetailsFooter(pricePerPerson: 4.92, priceForMeal: "13.36")
                CoursesURecipeDetailsFooter(pricePerPerson: 6.73, priceForMeal: "25.32")
                CoursesURecipeDetailsFooter(pricePerPerson: 1.34, priceForMeal: "6.78")
            }
        }
        
        GeometryReader { geometry in
            let safeArea = geometry.safeAreaInsets
            ZStack(alignment: .bottom) {
                ScrollView {
                    VStack {
                        LazyVStack(spacing: 0) {
                            ForEach(1..<11) { index in
                                VStack {
                                    Text("hello world \(index)")
                                    AsyncImage(url: URL(string: "https://picsum.photos/200/300")!) { image in
                                        image
                                            .resizable()
                                            .frame(minWidth: 0, maxWidth: .infinity, maxHeight: .infinity)
                                    }
                                }
                            }
                        }
                        .padding(.bottom, (geometry.safeAreaInsets.bottom + 150)) // Add padding for safe area at bottom
                    }
                }
                StickyFooter(safeArea: safeArea) {
                    CoursesURecipeDetailsFooter(pricePerPerson: 1.34, priceForMeal: "6.78")
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}
