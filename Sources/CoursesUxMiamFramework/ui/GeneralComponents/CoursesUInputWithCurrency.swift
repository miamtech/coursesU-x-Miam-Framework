//
//  MealPlannerBudget.swift
//  MiamIOSFramework
//
//  Created by didi on 5/9/23.
//  Copyright © 2023 Miam. All rights reserved.
//
//
import SwiftUI

@available(iOS 14, *)
internal struct CoursesUInputWithCurrency: View {
    @Binding public var budget: Double
    let currency: String

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
                .coursesUFontStyle(style: CoursesUFontStyleProvider().bodyBigBoldStyle)
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
            textField.textColor = .black
            let attributes: [NSAttributedString.Key: Any] = [
                    .foregroundColor: UIColor.lightGray // set placeholder text color to light gray
                ]
            textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
            
            // Add a toolbar with a Done button
                let toolbar = UIToolbar()
                toolbar.sizeToFit()
                let okButton = UIBarButtonItem(title: "OK", style: .done, target: context.coordinator, action: #selector(Coordinator.okButtonTapped))
                let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
                toolbar.items = [flexSpace, okButton]
                textField.inputAccessoryView = toolbar

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
            private var hasTappedOnTextField = false

            init(_ parent: CustomTextField) {
                self.parent = parent
            }
            
            @objc func okButtonTapped() {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                hasTappedOnTextField = false
                }
            
            func textFieldDidBeginEditing(_ textField: UITextField) {
                    if !hasTappedOnTextField {
                        textField.text = "" // Clear the text field's content only if the user has not tapped on it before
                    }
                    hasTappedOnTextField = true
                }

            func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
                let currentText = textField.text ?? ""
                guard let stringRange = Range(range, in: currentText) else { return false }
                let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
                
                // If the entered string makes the total characters more than 5, do not update the text field
                if updatedText.count > 5 {
                    return false
                }
                
                // If the updated text can be converted to Double, then update the parent value
                if let newValue = Double(updatedText) {
                    parent.value = newValue
                    textField.invalidateIntrinsicContentSize()
                }
                
                // The text field should update its text
                return true
            }
        }
    }



}
//
//@available(iOS 14, *)
//struct CoursesUInputWithIcon_Previews: PreviewProvider {
//    static var previews: some View {
//        @SwiftUI.State var myBudget = 4.0
//
//        CoursesUInputWithCurrency(
//            budget: $myBudget)
//            .background(Color.white)
//    }
//}
 
