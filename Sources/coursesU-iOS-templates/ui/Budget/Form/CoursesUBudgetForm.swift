//
//  SwiftUIView.swift
//  
//
//  Created by didi on 6/6/23.
//

import SwiftUI
import miamCore
import MiamIOSFramework

@available(iOS 14, *)
public struct CoursesUBudgetForm: BudgetForm {
    @SwiftUI.State var budget = 20.0
    @SwiftUI.State var numberGuests = 4
    @SwiftUI.State var numberMeals = 4
    let dimension = Dimension.sharedInstance
    public init() {}
    public func content(budgetInfos: BudgetInfos? = nil, isFetchingRecipes: Bool, onBudgetChanged: @escaping (BudgetInfos) -> Void, onFormValidated: @escaping (BudgetInfos) -> Void) -> some View {
        VStack(spacing: 20) {
            Text("Choissez vos repas de la semaine ou du mois selon votre budget :")
                .multilineTextAlignment(.center)
                .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.bodyBigBoldStyle)
            Divider()
            // TODO: localize
            CoursesUBudgetFormButtons(icon: Image.miamNeutralImage(icon: .guests), title: "Mon budget max")
            { _ in }
            Divider()
            // TODO: localize
            CoursesUBudgetFormButtons(icon: Image.miamNeutralImage(icon: .guests), title: "Nombre de personnes")
            { _ in }
            Divider()
            // TODO: localize
            CoursesUBudgetFormButtons(icon: Image.miamNeutralImage(icon: .guests), title: "Nombre de repas")
            { _ in }
            Divider()
            CoursesUButtonStyle(
                backgroundColor: Color.primaryColor,
                content: { HStack {
                    Image.miamImage(icon: .search)
                    Text("C'est parti !")
                        .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.bodyStyle)
                        .foregroundColor(Color.white)
             
                }}, buttonAction: { })
        }
        .padding(25)
        .background(Color.white)
        .border(Color.gray, width: 0.5)
        .cornerRadius(Dimension.sharedInstance.mCornerRadius)
        
    }
    
}

@available(iOS 14, *)
struct CoursesUBudgetFormButtons: View {
    @SwiftUI.State public var value: Int = 0
    let icon: Image
    let title: String
    let minValue: Int = 1
    let maxValue: Int = 10
    public var onStepperChanged: (Int) -> Void
    init(defaultValue: Int = 0, icon: Image, title:String, minValue: Int = 1, maxValue: Int = 10, onStepperChanged: @escaping (Int) -> Void) {
        _value = State(initialValue: defaultValue)
        self.icon = icon
        self.title = title
        self.onStepperChanged = onStepperChanged
    }
    let dimension = Dimension.sharedInstance
    var body: some View {
        HStack() {
            
            icon
                .renderingMode(.template)
                .resizable()
                .frame(width: dimension.lButtonHeight, height: dimension.lButtonHeight)
                .padding(.horizontal, dimension.sPadding)
                .foregroundColor(Color.miamColor(.black))
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.bodyStyle)
                Text(String(Int(value)))
                    .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.bodyBigBoldStyle)
            }
//            .padding(.leading, dimension.mPadding)
            
            Spacer()
        }
        
            
    }
}
@available(iOS 14, *)
struct CoursesUBudgetForm_Previews: PreviewProvider {
   

    static var previews: some View {
        CoursesUBudgetForm().content(isFetchingRecipes: false, onBudgetChanged: { budgetInfos in
            print("Budget changed: \(budgetInfos)")
        }, onFormValidated: { _ in })

        ZStack(alignment: .top) {
            Color.budgetBackgroundColor
            VStack(spacing: -40.0) {
                BudgetBackground()
                CoursesUBudgetForm().content(isFetchingRecipes: false, onBudgetChanged: { budgetInfos in
                    print("Budget changed: \(budgetInfos)")
                }, onFormValidated: { _ in })
                .padding([.horizontal, .bottom], 25)
            }
            
        }
    }
    
}
