//
//  CoursesUCounterView.swift
//  
//
//  Created by didi on 7/6/23.
//

import SwiftUI
import mealzcore
import MealziOSSDK

@available(iOS 14, *)
public struct CoursesUCounterView: View {
    @Binding public var count: Int
    public var maxValue: Int
    public var minValue: Int
    public var isLoading: Bool
    public var isDisable: Bool
    
    public init(count: Binding<Int>, maxValue: Int = 99, minValue: Int = 0, isLoading: Bool = false, isDisable: Bool = false) {
        _count = count
        self.maxValue = maxValue
        self.minValue = minValue
        self.isLoading = isLoading
        self.isDisable = isDisable
    }
    
    private func newValueBounded(newValue: Int) -> Bool {
        return newValue >= minValue && newValue <= maxValue
    }
    
    private func increase() {
        if !newValueBounded(newValue: count + 1) { return }
        count += 1
    }
    
    private  func decrease() {
        if !newValueBounded(newValue: count - 1) { return }
        count -= 1
    }
    
    var maxButtonColor: Color {
        return (count >= maxValue || isDisable) ? Color.gray : Color.mealzColor(.primary)
    }
    var minButtonColor: Color {
        return (count <= minValue || isDisable) ? Color.gray : Color.mealzColor(.primary)
    }
    
    public var body: some View {
        HStack {
            Button {
                decrease()
            } label: {
                Image(systemName: "minus")
                    .scaleEffect(1.2)
                    .foregroundColor(minButtonColor)
                    .padding(Dimension.sharedInstance.sPadding)
            }
            .overlay(
                Circle()
                    .stroke(minButtonColor, lineWidth: 2)
                    .frame(width: Dimension.sharedInstance.lButtonHeight, height: Dimension.sharedInstance.lButtonHeight)
            )
            .padding(.leading, Dimension.sharedInstance.mPadding)
            .disabled(self.isDisable)
            ZStack {
                if isLoading {
                    ProgressLoader(color: Color.white)
                        .scaleEffect(0.3)
                } else {
                    Text("\(count)")
                        .coursesUFontStyle(style: CoursesUFontStyleProvider().bodyBoldStyle)
                        .foregroundColor(Color.black)
                }
            }.frame(width: 20)
            Button {
                increase()
            } label: {
                Image(systemName: "plus")
                    .scaleEffect(1.2)
                    .foregroundColor(maxButtonColor)
                    .padding(Dimension.sharedInstance.sPadding)
            }
            .overlay(
                Circle()
                    .stroke(minButtonColor, lineWidth: 2)
                    .frame(width: Dimension.sharedInstance.lButtonHeight, height: Dimension.sharedInstance.lButtonHeight)
            )
            .padding(.trailing, Dimension.sharedInstance.mPadding)
            .disabled(self.isDisable)
            
        }.frame(width: 110.0, height: 50.0, alignment: .center)
            .background(Color.lightGrayBackground)
            .cornerRadius(25.0)
            .overlay(
                RoundedRectangle(cornerRadius: 25.0)
                    .stroke(Color.gray, lineWidth: 0.5)
            )
            .padding(Dimension.sharedInstance.sPadding)
    }
}
