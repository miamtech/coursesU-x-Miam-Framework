//
//  MealPlannerBudget.swift
//  MiamIOSFramework
//
//  Created by didi on 5/9/23.
//  Copyright © 2023 Miam. All rights reserved.
//
//
import SwiftUI

//@available(iOS 14, *)
//internal struct CoursesUInputWithIcon: View {
//    @State private var budget: Double = 0.0
//    let caption: String?
//    let currency: String
//    let icon: Image
//    public var onInputChanged: (Double) -> Void
//    init(
//        defaultValue: Double? = 0,
//        currency: String = "€",
//        caption: String? = nil,
//        icon: Image,
//        onInputChanged: @escaping (Double) -> Void
//    ) {
//        _budget = State(initialValue: defaultValue ?? 0.0)
//        self.currency = currency
//        self.caption = caption
//        self.icon = icon
//        self.onInputChanged = onInputChanged
//    }
//    let dimension = Dimension.sharedInstance
//    var body: some View {
//        HStack(spacing: Dimension.sharedInstance.sPadding) {
//            icon
//                .resizable()
//                .frame(width: dimension.lButtonHeight, height: dimension.lButtonHeight)
//                .padding(.horizontal, dimension.sPadding)
//
//            VStack(alignment: .leading, spacing: 0) {
//                if let caption = caption {
//                    Text(caption)
//                        .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.bodyStyle)
//                }
//                HStack(spacing: 2) {
//                    Text(currency)
////                    NumberedInputField(budget: $budget, onInputChanged: onInputChanged)
//                }
//            }
//            Spacer()
//        }
//    }
//}

@available(iOS 14, *)
internal struct CoursesUInputWithCurrency: View {
    @Binding public var budget: Double
    let currency: String
//    public var onInputChanged: (Double) -> Void

    init(budget: Binding<Double>, currency: String = "€") {
        _budget = budget
        self.currency = currency
        
    }

    var body: some View {
        HStack(alignment: .center, spacing: 2) {
            
            Spacer()

            CustomTextField("Budget", value: $budget)
                .coursesUFontStyle(style: CoursesUFontStyleProvider().bodyBigBoldStyle)
            Text(currency)
            }
        }
    
    @available(iOS 14, *)
    struct CustomTextField: UIViewRepresentable {
        private var placeholder: String
        @Binding private var value: Double

        init(_ placeholder: String, value: Binding<Double>) {
            self.placeholder = placeholder
            self._value = value
        }

        func makeUIView(context: Context) -> UITextField {
            let textField = UITextField(frame: .zero)
            textField.delegate = context.coordinator
            textField.borderStyle = .none // remove border
            textField.placeholder = placeholder
            textField.textAlignment = .right // align text to right
            textField.keyboardType = .numberPad // use number pad keyboard

            return textField
        }

        func updateUIView(_ uiView: UITextField, context: Context) {
            let intValue = Int(value)
            uiView.text = value == Double(intValue) ? String(intValue) : String(format: "%.2f", value)
        }

        func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }

        class Coordinator: NSObject, UITextFieldDelegate {
            var parent: CustomTextField

            init(_ parent: CustomTextField) {
                self.parent = parent
            }

            func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
                if let text = textField.text,
                   let textRange = Range(range, in: text) {
                    let updatedText = text.replacingCharacters(in: textRange, with: string)
                    if updatedText.count <= 5 { // restrict to 5 characters
                        if let newValue = Double(updatedText) { // convert String to Double
                            parent.value = newValue
                            textField.invalidateIntrinsicContentSize()
                        }
                        return true
                    }
                }
                return false
            }
        }
    }



}

//@available(iOS 14, *)
//struct CoursesUInputWithIcon_Previews: PreviewProvider {
//    static var previews: some View {
//        CoursesUInputWithCurrency(
//            currency: "$",
//            caption: "Total Budget",
//            icon: Image(packageResource: "numberOfMealsIcon", ofType: "png")) { num in
//                print("num is " + String(num))
//            }
//            .background(Color.white)
//    }
//}
