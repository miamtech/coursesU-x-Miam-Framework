//
//  SwiftUIView.swift
//  
//
//  Created by didi on 6/6/23.
//

import SwiftUI


@available(iOS 14, *)
internal struct CoursesUStepperCollapsed: View {
    @State public var value: Int = 0
    let icon: Image
    let minValue: Int = 1
    let maxValue: Int = 10
    public var onStepperChanged: (Int) -> Void
    init(defaultValue: Int = 0, icon: Image, minValue: Int = 1, maxValue: Int = 10, onStepperChanged: @escaping (Int) -> Void) {
        _value = State(initialValue: defaultValue)
        self.icon = icon
        self.onStepperChanged = onStepperChanged
    }
    @State var showBackground = false
    let dimension = Dimension.sharedInstance
    var body: some View {
        VStack(spacing: dimension.sPadding) {
            Menu {
                ForEach(minValue..<maxValue) { number in
                    Button(action: {
                        value = number
                        onStepperChanged(value)
                        showBackground = false
                    }, label: { Text(String(number))
                    })
                }
            } label: {
                HStack(spacing: 0) {
                    icon
                        .resizable()
                        .frame(width: dimension.lButtonHeight, height: dimension.lButtonHeight)
                        .padding(.horizontal, dimension.sPadding)
                        .foregroundColor(Color.miamColor(.black))
                    Text(String(Int(value)))
                        .foregroundColor(Color.black)
                        .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.bodyBigBoldStyle)
                        .padding(.leading, dimension.mPadding)
                    Spacer()
                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .overlay(RoundedRectangle(cornerRadius: Dimension.sharedInstance.sCornerRadius)
            .stroke(Color.miamColor(showBackground ? .primary : .grey), lineWidth: (showBackground ? 1.0 : 0.5)))
        .onTapGesture {
            showBackground = true
        }
    }
}

@available(iOS 14, *)
struct CoursesUStepperCollapsed_Previews: PreviewProvider {
    static var previews: some View {
            StepperPreviewWrapper()
        }

        struct StepperPreviewWrapper: View {
            @State private var value = 4

            var body: some View {
                VStack {
                    CoursesUStepperCollapsed(defaultValue: value, icon: Image(packageResource: "numberOfMealsIcon", ofType: "png")) { num in
                        value = num}
                }
            }
    }
}
