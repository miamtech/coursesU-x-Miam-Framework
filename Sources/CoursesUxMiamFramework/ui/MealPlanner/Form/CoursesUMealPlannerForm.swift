//
//  SwiftUIView.swift
//
//
//  Created by didi on 6/6/23.
//

import mealzcore
import MealziOSSDK
import SwiftUI

@available(iOS 14, *)
struct CoursesUStepperBinding: View {
    @Binding var value: Int
    let minValue: Int
    let maxValue: Int
    let disableButton: Bool
    let dimension = Dimension.sharedInstance
    init(value: Binding<Int>, minValue: Int = 0, maxValue: Int = 99, disableButton: Bool = false) {
        _value = value
        self.minValue = minValue
        self.maxValue = maxValue
        self.disableButton = disableButton
    }

    var maxButtonColor: Color {
        return (value >= maxValue || disableButton) ? Color.gray : Color.mealzColor(.primary)
    }

    var minButtonColor: Color {
        return (value <= minValue || disableButton) ? Color.gray : Color.mealzColor(.primary)
    }

    var body: some View {
        HStack(spacing: dimension.lPadding) {
            Button(action: {
                if value > minValue {
                    value -= 1
                }
            }, label: {
                Image(systemName: "minus")
                    //                            .resizable()
                    .foregroundColor(minButtonColor)
                    .padding(dimension.sPadding)
                    .overlay(
                        Circle()
                            .stroke(minButtonColor, lineWidth: 1)
                            .frame(width: dimension.lButtonHeight, height: dimension.lButtonHeight)
                    )
            })
            .disabled(value <= minValue)
            .disabled(disableButton)
            Text("\(value)")
                .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.bodyBigBoldStyle)
            Button(action: {
                if value < maxValue {
                    value += 1
                }
            }, label: {
                Image(systemName: "plus")
                    //                            .resizable()
                    .foregroundColor(maxButtonColor)
                    .padding(dimension.sPadding)
                    .overlay(
                        Circle()
                            .stroke(maxButtonColor, lineWidth: 1)
                            .frame(width: dimension.lButtonHeight, height: dimension.lButtonHeight)
                    )
            })
            .disabled(value >= maxValue)
            .disabled(disableButton)
        }
        .padding(dimension.mPadding)
    }
}

@available(iOS 14, *)
struct CoursesUStepperWithCallback: View {
    @SwiftUI.State public var count: Int
    let minValue: Int
    let maxValue: Int
    let disableButton: Bool
    var buttonSize: CGFloat
    var textFontStyle: CoursesUFontStyle = CoursesUFontStyleProvider.sharedInstance.bodyBigBoldStyle
    var textToDisplay: String
    var subtextFontStyle: CoursesUFontStyle = CoursesUFontStyleProvider.sharedInstance.bodyStyle
    var onValueChanged: (Int) -> Void
    let dimension = Dimension.sharedInstance
    init(count: Int, minValue: Int = 0, maxValue: Int = 99, disableButton: Bool = false, buttonSize: CGFloat = Dimension.sharedInstance.lButtonHeight, textFontStyle: CoursesUFontStyle = CoursesUFontStyleProvider.sharedInstance.bodyBigBoldStyle, textToDisplay: String = "", subtextFontStyle: CoursesUFontStyle = CoursesUFontStyleProvider.sharedInstance.bodyStyle, onValueChanged: @escaping (Int) -> Void) {
        self.minValue = minValue
        self.maxValue = maxValue
        self.disableButton = disableButton
        self.buttonSize = buttonSize
        self.textFontStyle = textFontStyle
        self.textToDisplay = textToDisplay
        self.onValueChanged = onValueChanged
        self.subtextFontStyle = subtextFontStyle
        self._count = State(initialValue: count)
    }

    var maxButtonColor: Color {
        return (count >= maxValue || disableButton) ? Color.gray : Color.mealzColor(.primary)
    }

    var minButtonColor: Color {
        return (count <= minValue || disableButton) ? Color.gray : Color.mealzColor(.primary)
    }

    var body: some View {
        HStack(spacing: dimension.mPadding) {
            Button(action: {
                if count > minValue {
                    count -= 1
                    onValueChanged(count)
                }
            }, label: {
                Image(systemName: "minus")
                    //                            .resizable()
                    .foregroundColor(minButtonColor)
                    .padding(dimension.sPadding)
                    .overlay(
                        Circle()
                            .stroke(minButtonColor, lineWidth: 2)
                            .frame(width: buttonSize, height: buttonSize)
                    )
            })
            .disabled(count <= minValue)
            .disabled(disableButton)
            VStack {
                Text("\(count)")
                    .coursesUFontStyle(style: textFontStyle)
                if textToDisplay != "" {
                    Text(textToDisplay)
                        .coursesUFontStyle(style: subtextFontStyle)
                }
            }
            Button(action: {
                if count < maxValue {
                    count += 1
                    onValueChanged(count)
                }
            }, label: {
                Image(systemName: "plus")
                    .foregroundColor(maxButtonColor)
                    .padding(dimension.sPadding)
                    .overlay(
                        Circle()
                            .stroke(maxButtonColor, lineWidth: 2)
                            .frame(width: buttonSize, height: buttonSize)
                    )
            })
            .disabled(count >= maxValue)
            .disabled(disableButton)
        }
        .padding(dimension.mPadding)
    }
}

@available(iOS 14, *)
struct CoursesUFormRow<Content: View>: View {
    let caption: String?
    let icon: Image
    let content: Content
    let isBudget: Bool
    init(
        caption: String? = nil,
        icon: Image,
        content: Content,
        isBudget: Bool = false
    ) {
        self.content = content
        self.caption = caption
        self.icon = icon
        self.isBudget = isBudget
    }

    let dimension = Dimension.sharedInstance
    var body: some View {
        HStack(spacing: Dimension.sharedInstance.sPadding) {
            icon
                .resizable()
                .frame(width: dimension.lButtonHeight, height: dimension.lButtonHeight)
                .padding(.horizontal, dimension.sPadding)

            if let caption = caption {
                HStack {
                    if isBudget {
                        Text(caption)
                            .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.bodyStyleMulish)
                    } else {
                        Text(caption)
                            .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.bodyStyle)
                    }
                    Spacer()
                }
                .frame(maxWidth: 100)
                Spacer()
            }

            content
        }
        .frame(height: 50)
    }
}

@available(iOS 14, *)
struct CoursesUTwoMealsBackground: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Image(packageResource: "BudgetLeftSideBg", ofType: "png")
                Spacer()
                Image(packageResource: "BudgetRightSideBg", ofType: "png")
            }
        }
    }
}
