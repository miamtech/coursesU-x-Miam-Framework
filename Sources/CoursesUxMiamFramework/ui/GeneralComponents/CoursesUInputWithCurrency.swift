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
    @Binding public var activelyEditing: Bool
    let currency: String
    
    init(
        budget: Binding<Double>,
        activelyEditing: Binding<Bool>,
        currency: String = "€"
    ) {
        _budget = budget
        _activelyEditing = activelyEditing
        self.currency = currency
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 2) {
            Spacer()
            CustomTextField("Budget", value: $budget, activelyEditing: $activelyEditing)
                .coursesUFontStyle(style: CoursesUFontStyleProvider().bodyBigBoldStyle)
            Text(currency)
                .coursesUFontStyle(style: CoursesUFontStyleProvider().bodyBigBoldStyle)
        }
    }
    
    @available(iOS 14, *)
    struct CustomTextField: UIViewRepresentable {
        private var placeholder: String
        @Binding private var value: Double
        @Binding private var activelyEditing: Bool
        
        init(_ placeholder: String, value: Binding<Double>, activelyEditing: Binding<Bool>) {
            self.placeholder = placeholder
            self._value = value
            self._activelyEditing = activelyEditing
        }
        
        func makeUIView(context: Context) -> UITextField {
            let textField = UITextField(frame: .zero)
            context.coordinator.textField = textField
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
            let displayValue = context.coordinator.tempValue == 0.0 ? value : context.coordinator.tempValue
            let intValue = Int(displayValue)
            uiView.text = displayValue == Double(intValue) ? String(intValue) : String(format: "%.2f", displayValue)
        }
        
        func makeCoordinator() -> Coordinator {
            Coordinator(self, activelyEditing: $activelyEditing)
        }
        
        class Coordinator: NSObject, UITextFieldDelegate {
            var parent: CustomTextField
            @Binding var activelyEditing: Bool
            var hasTappedOnTextField = false
            var textField: UITextField?
            var tempValue: Double = 0.0
            var tapGesture: UITapGestureRecognizer?
            
            init(_ parent: CustomTextField, activelyEditing: Binding<Bool>) {
                self.parent = parent
                self._activelyEditing = activelyEditing
            }
            
            func textFieldDidBeginEditing(_ textField: UITextField) {
                tempValue = parent.value // Initialize tempValue with the current value of budget
                if !hasTappedOnTextField {
                    // Select the entire text
                    textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)
                    activelyEditing = true
                }
                hasTappedOnTextField = true
                
                // Add tap gesture recognizer to the main window to dismiss keyboard
                tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
                if let window = UIApplication.shared.windows.first {
                    window.addGestureRecognizer(tapGesture!)
                }
            }
            
            func userFinishedTyping() {
                parent.value = tempValue
                hasTappedOnTextField = false
                activelyEditing = false
            }
            
            @objc func okButtonTapped() {
                userFinishedTyping()
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            
            @objc func dismissKeyboard() {
                textField?.resignFirstResponder()
                userFinishedTyping()
                
                // Remove tap gesture recognizer from the main window
                if let tapGesture = tapGesture, let window = UIApplication.shared.windows.first {
                    window.removeGestureRecognizer(tapGesture)
                }
            }
            
            func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
                let currentText = textField.text ?? ""
                guard let stringRange = Range(range, in: currentText) else { return false }
                let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
                
                // If the entered string makes the total characters more than 5, do not update the text field
                if updatedText.count > 5 {
                    return false
                }
                
                // If the updated text can be converted to Double, then update tempValue
                if let newValue = Double(updatedText) {
                    tempValue = newValue
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

