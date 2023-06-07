//
//  MiamBudgetPlannerStickyFooter.swift
//  MiamIOSFramework
//
//  Created by didi on 5/23/23.
//  Copyright © 2023 Miam. All rights reserved.
//

import SwiftUI
import miamCore
import MiamIOSFramework

@available(iOS 14, *)
struct CoursesUBudgetPlannerStickyFooter: View {
    @Binding var budgetSpent: Double
    var totalBudgetPermitted: Double
    let buttonAction: () -> Void
    let dimension = Dimension.sharedInstance
    var body: some View {
        HStack {
            CoursesUBudgetPlannerBudgetFooter(budgetSpent: $budgetSpent, totalBudgetPermitted: totalBudgetPermitted)
            Spacer()
            CoursesUButtonStyle(backgroundColor: Color.primaryColor, content: { HStack {
//                Image(packageResource: "basket", ofType: "png")
                Image(systemName: "basket")
                    .resizable()
                    .foregroundColor(Color.white)
                    .frame(width: 20, height: 20)
                Text("Tout ajouter")
                    .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.bodyStyle)
                    .foregroundColor(Color.white)
         
            }}, buttonAction: { })
        }
        .frame(maxWidth: .infinity)
        .frame(height: 90)
        .padding(.horizontal)
        .background(Color.white)
        .cornerRadius(dimension.lCornerRadius, corners: [.top])
    }
}


@available(iOS 14, *)
struct WithRoundedCornersProgressViewStyle: ProgressViewStyle {
    var progressColor: Color
    var overBudget: Bool
    let widthOfRectangles = CGFloat(150)
    let dimension = Dimension.sharedInstance
    func makeBody(configuration: Configuration) -> some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: dimension.mCornerRadius)
                .frame(width: widthOfRectangles, height: 10)
                .foregroundColor(Color.gray)
            Rectangle()
                .frame(width: CGFloat(configuration.fractionCompleted ?? 0) * widthOfRectangles, height: 10)
                .foregroundColor(progressColor)
                .cornerRadius(dimension.mCornerRadius, corners: [.topLeft, .bottomLeft])
            // round end corners if == to 100
                .cornerRadius(dimension.mCornerRadius, corners: (configuration.fractionCompleted ?? 0 > 0.99) ? .allCorners : .left)
            if overBudget {
                HStack {
                    Spacer()
                    Rectangle()
                        .frame(maxWidth: .infinity)
                        .frame(width: 0.3 * widthOfRectangles, height: 10)
                        .foregroundColor(Color.red)
                        .cornerRadius(dimension.mCornerRadius, corners: .right)
                }
            }
        }
    }
}

@available(iOS 14, *)
struct CoursesUBudgetPlannerBudgetFooter: View {
    @Binding var budgetSpent: Double
    var totalBudgetPermitted: Double
    let dimension = Dimension.sharedInstance
    var body: some View {
        VStack(alignment: .leading, spacing: dimension.mPadding) {
//            Text(String(budgetSpent) + " €")
//                .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.titleStyle)
//                .foregroundColor(budgetSpent > totalBudgetPermitted ?
//                                 Color.red : Color.green)
            ProgressView(value: budgetSpent, total: totalBudgetPermitted)
                .progressViewStyle(WithRoundedCornersProgressViewStyle(progressColor: Color.primaryColor, overBudget: budgetSpent > totalBudgetPermitted ? true : false))
           
        
            YellowSubtext(text: String(budgetSpent) + " €", fontStyle: CoursesUFontStyleProvider.sharedInstance.titleBigStyle, imageWidth: 70)
                        
            
        }
    }
}

@available(iOS 14, *)
struct CoursesUBudgetPlannerStickyFooter_Previews: PreviewProvider {
    static var previews: some View {
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
                    CoursesUBudgetPlannerStickyFooter(budgetSpent: .constant(22.0), totalBudgetPermitted: 50.0) { print("hello world")
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

@available(iOS 14, *)
struct StickyFooter<Content: View>: View {
    var safeArea: EdgeInsets
    let content: () -> Content
    var body: some View {
        content()
            .padding(.bottom, safeArea.bottom)
            .background(Color.miamColor(.white))
    }
}
