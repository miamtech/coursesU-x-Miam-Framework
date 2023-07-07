//
//  CoursesUCounterView.swift
//  
//
//  Created by didi on 7/6/23.
//

import SwiftUI

@available(iOS 14, *)
public struct CoursesUCounterView: View {
    @Binding public var count: Int
    public var maxValue: Int?
    public var minValue: Int?
    public var isLoading: Bool
    public var isDisable: Bool
    
    public init(count: Binding<Int>, maxValue: Int? = nil, minValue: Int? = nil, isLoading: Bool = false, isDisable: Bool = false) {
        _count = count
        self.maxValue = maxValue
        self.minValue = minValue
        self.isLoading = isLoading
        self.isDisable = isDisable
    }

    private func newValueBounded(newValue: Int) -> Bool {
        guard let minValue, let maxValue else {
            return true
        }
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

    public var body: some View {
//            if let template = Template.sharedInstance.counterViewTemplate {
//                template(count, {increase()}(), {decrease()})
//            } else {
            HStack {
                Button {
                    decrease()
                } label: {
                    Image(systemName: "minus")
                        .resizable()
                        .frame(width: 12, height: 2)
                        .foregroundColor(Color.black)
                        .padding(Dimension.sharedInstance.lPadding)
                }
                .frame(width: 20.0, height: 20.0, alignment: .leading)
                .disabled(self.isDisable)

                Spacer()
                if isLoading {
                    ProgressLoader(color: Color.white)
                        .scaleEffect(0.5)
                } else {
                    Text("\(count)")
                        .coursesUFontStyle(style: CoursesUFontStyleProvider().bodyBoldStyle)
                        .foregroundColor(Color.black)
                    Spacer()
                }
                Button {
                   increase()
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 12, height: 12)
                        .foregroundColor(Color.black)
                        .padding(Dimension.sharedInstance.lPadding)
                }
                
                .frame(width: 20.0, height: 20.0, alignment: .trailing)
                .disabled(self.isDisable)

            }.frame(width: 100.0, height: 40.0, alignment: .center)
                .background(Color.lightGray)
                .cornerRadius(25.0)
                
                .overlay(
                    RoundedRectangle(cornerRadius: 25.0)
                        .stroke(Color.gray, lineWidth: 0.5)
                )
                .padding( Dimension.sharedInstance.mPadding)

            
//            }
    }
}