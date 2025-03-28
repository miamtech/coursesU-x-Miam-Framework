//
//  MiamBudgetPlannerStickyFooter.swift
//  MiamIOSFramework
//
//  Created by didi on 5/23/23.
//  Copyright © 2023 Miam. All rights reserved.
//

import mealzcore
import MealziOSSDK
import SwiftUI

public class MealPlannerSingleton {
    public static var budget: Double = 0
}

@available(iOS 14, *)
public struct CoursesUMealPlannerFooter: MealPlannerResultsFooterProtocol {
    public init() {}

    public func content(params: MealPlannerResultsFooterParameters) -> some View {
        MealPlannerSingleton.budget = params.mealPlannerCriteria.availableBudget

        return CoursesUBudgetPlannerStickyFooter(
            budgetSpent: params.budgetSpent.wrappedValue,
            totalBudgetPermitted: params.mealPlannerCriteria.availableBudget,
            footerContent:
            HStack {
                Image(packageResource: "ShoppingCartIcon", ofType: "png")
                    .resizable()
                    .foregroundColor(Color.white)
                    .frame(width: 20, height: 20)
                Text("Tout ajouter")
                    .foregroundColor(Color.white)
                    .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.bodyStyle)
            }) {
                params.onValidateTapped()
            }
            .frame(height: params.heightOfFooter)
    }
}

@available(iOS 14, *)
struct CoursesUBudgetPlannerStickyFooter<FooterContent: View>: View {
    var budgetSpent: Double
    var totalBudgetPermitted: Double
    let footerContent: FooterContent
    let buttonAction: () -> Void
    let dimension = Dimension.sharedInstance
    var body: some View {
        HStack {
            Spacer()
            CoursesUBudgetPlannerBudgetFooter(budgetSpent: budgetSpent, totalBudgetPermitted: totalBudgetPermitted)
            Spacer()
            CoursesUButtonStyle(backgroundColor: Color.mealzColor(.primary), content: {
                footerContent
            }, buttonAction: {
                buttonAction()
            })
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .cornerRadius(dimension.lCornerRadius, corners: [.top]).edgesIgnoringSafeArea(.bottom)
    }
}

@available(iOS 14, *)
struct WithRoundedCornersProgressViewStyle: ProgressViewStyle {
    var progressColor: Color
    var overBudget: Bool
    let widthOfRectangles: CGFloat
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
                        .frame(width: 0.2 * widthOfRectangles, height: 10)
                        .foregroundColor(Color.red)
                        .cornerRadius(dimension.mCornerRadius, corners: .right)
                }
            }
        }
        .frame(width: widthOfRectangles)
    }
}

@available(iOS 14, *)
struct CoursesUBudgetPlannerBudgetFooter : View {
    var budgetSpent: Double
    var totalBudgetPermitted: Double
    let dimension = Dimension.sharedInstance
    let widthOfFrame = CGFloat(150)
    var body: some View {
        VStack(alignment: .leading, spacing: dimension.sPadding) {
            if budgetSpent > totalBudgetPermitted + 0.5 {
                HStack {
                    Spacer()
                    Text(String(format: "+%.2f €", budgetSpent - totalBudgetPermitted))
                        .foregroundColor(Color.red
                        )
                        .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.bodyStyleMulish)
                        .padding(5)
                        .background(
                            ChatBubbleShape().fill(Color.overBudgetBackgroundColor)
                        )
                }
            }
            ProgressView(value: budgetSpent, total: totalBudgetPermitted)
                .progressViewStyle(WithRoundedCornersProgressViewStyle(progressColor: Color.mealzColor(.primary), overBudget: budgetSpent > totalBudgetPermitted ? true : false, widthOfRectangles: widthOfFrame))
            HStack {
                Spacer()
                YellowSubtext(text: String(format: "%.2f €", budgetSpent), fontStyle: CoursesUFontStyleProvider.sharedInstance.titleBigStyleMulish, imageWidth: 70)
            }
        }
        .frame(width: widthOfFrame)
    }
}

@available(iOS 14, *)
struct ChatBubbleShape: Shape {
    var cornerRadius: CGFloat = 4
    var triangleHeight: CGFloat = 5
    var triangleWidth: CGFloat = 10
    var triangleOffset: CGFloat = 1.4

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let bubbleRect = rect.insetBy(dx: 0, dy: triangleHeight)

        path.addRoundedRect(in: bubbleRect, cornerSize: CGSize(width: cornerRadius, height: cornerRadius))

        let triangleRect = CGRect(x: rect.midX - triangleWidth / 2,
                                  y: rect.maxY - triangleHeight,
                                  width: triangleWidth,
                                  height: triangleHeight)
        path.move(to: CGPoint(x: triangleRect.midX * triangleOffset, y: triangleRect.maxY))
        path.addLine(to: CGPoint(x: triangleRect.minX * triangleOffset, y: triangleRect.minY))
        path.addLine(to: CGPoint(x: triangleRect.maxX * triangleOffset, y: triangleRect.minY))

        return path
    }
}

#if DEBUG
@available(iOS 14, *)
struct CoursesUBudgetPlannerStickyFooter_Previews: PreviewProvider {
    static var previews: some View {
        let criteria = MealPlannerCriteria(availableBudget: 40, numberOfGuests: 4, numberOfMeals: 5)
        ZStack {
            Color.budgetBackgroundColor
            VStack {
                CoursesUMealPlannerFooter().content(params: MealPlannerResultsFooterParameters(
                    mealPlannerCriteria: criteria,
                    heightOfFooter: 80,
                    budgetSpent: .constant(40),
                    onValidateTapped: {}))
                CoursesUMealPlannerFooter().content(params: MealPlannerResultsFooterParameters(
                    mealPlannerCriteria: criteria,
                    heightOfFooter: 80,
                    budgetSpent: .constant(50.0),
                    onValidateTapped: {}))
                CoursesUMealPlannerFooter().content(params: MealPlannerResultsFooterParameters(
                    mealPlannerCriteria: criteria,
                    heightOfFooter: 80,
                    budgetSpent: .constant(30.0),
                    onValidateTapped: {}))
                CoursesUMealPlannerFooter().content(params: MealPlannerResultsFooterParameters(
                    mealPlannerCriteria: criteria,
                    heightOfFooter: 80,

                    budgetSpent: .constant(20),
                    onValidateTapped: {}))
            }
        }

        GeometryReader { geometry in
            let safeArea = geometry.safeAreaInsets
            ZStack(alignment: .bottom) {
                ScrollView {
                    VStack {
                        LazyVStack(spacing: 0) {
                            ForEach(1 ..< 11) { index in
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
                        .padding(.bottom, geometry.safeAreaInsets.bottom + 150) // Add padding for safe area at bottom
                    }
                }
                StickyFooter(safeArea: safeArea) {
                    CoursesUMealPlannerFooter().content(params: MealPlannerResultsFooterParameters(
                        mealPlannerCriteria: criteria,
                        heightOfFooter: 80,
                        budgetSpent: .constant(20),
                        onValidateTapped: {}))
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
            .background(Color.mealzColor(.white))
    }
}
#endif
