//
//  MealPlannerBudget.swift
//  MiamIOSFramework
//
//  Created by didi on 5/9/23.
//  Copyright © 2023 Miam. All rights reserved.
//

import SwiftUI
@available(iOS 14, *)
internal struct CoursesUInputWithIcon: View {
    @State private var budget: Double = 0.0
    let caption: String?
    let icon: Image
    public var onInputChanged: (Double) -> Void
    init(
        defaultValue: Double? = 0,
        caption: String? = nil,
        icon: Image,
        onInputChanged: @escaping (Double) -> Void
    ) {
        _budget = State(initialValue: defaultValue ?? 0.0)
        self.caption = caption
        self.icon = icon
        self.onInputChanged = onInputChanged
    }
    let dimension = Dimension.sharedInstance
    var body: some View {
        HStack(spacing: Dimension.sharedInstance.sPadding) {
            icon
                .resizable()
                .frame(width: dimension.lButtonHeight, height: dimension.lButtonHeight)
                .padding(.horizontal, dimension.sPadding)
                
            
            VStack(alignment: .leading, spacing: 0) {
                if let caption = caption {
                    Text(caption)
                        .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.bodyStyle)
                }
                NumberedInputField(budget: $budget, onInputChanged: onInputChanged)
            }
            Spacer()
        }
    }
}

@available(iOS 14, *)
internal struct NumberedInputField: View {
    @Binding public var budget: Double
    public var onInputChanged: (Double) -> Void

    var body: some View {
        if #available(iOS 15, *) {
        TextField("", value: $budget, format: .currency(code: "EUR"))
                .coursesUFontStyle(style: CoursesUFontStyleProvider().bodyBigBoldStyle)
                .multilineTextAlignment(.leading)
                .keyboardType(.numberPad)
                .onChange(of: budget) { newValue in
                    onInputChanged(newValue)
                }
        } else {
                // Fallback on earlier versions
            TextField("", value: $budget, formatter: NumberFormatter())
                    .coursesUFontStyle(style: CoursesUFontStyleProvider().bodyBigBoldStyle)
                    .multilineTextAlignment(.leading)
                    .keyboardType(.numberPad)
                    .onChange(of: budget) { newValue in
                        onInputChanged(newValue)
                    }
            }
    }
}

@available(iOS 14, *)
struct CoursesUInputWithIcon_Previews: PreviewProvider {
    static var previews: some View {
        CoursesUInputWithIcon(
            caption: "Total Budget",
            icon: Image(packageResource: "numberOfMealsIcon", ofType: "png")) { num in
                print("num is " + String(num))
            }
            .background(Color.white)
    }
}
