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
        ZStack(alignment: .top) {
            VStack {
                Spacer()
                HStack() {
                    Image(packageResource: "BudgetLeftSideBg", ofType: "png")
                    Spacer()
                    Image(packageResource: "BudgetRightSideBg", ofType: "png")
                }
            }
            VStack(spacing: 20) {
                Text("Choissez vos repas de la semaine ou du mois selon votre budget :")
                    .multilineTextAlignment(.center)
                    .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.bodyBigBoldStyle)
                Divider()
                // TODO: localize
                CoursesUInputWithIcon(caption: "Mon budget max", icon: Image(packageResource: "BudgetIcon", ofType: "png"))
                { _ in }
                Divider()
                // TODO: localize
                CoursesUStepperCollapsed(caption: "Nombre de personnes", icon: Image(packageResource: "numberOfMealsIcon", ofType: "png"))
                { _ in }
                Divider()
                // TODO: localize
                CoursesUStepperCollapsed(caption: "Nombre de repas", icon: Image(packageResource: "numberOfPeopleIcon", ofType: "png"))
                { _ in }
                Divider()
                CoursesUButtonStyle(
                    backgroundColor: Color.primaryColor,
                    content: { HStack {
                        Image(packageResource: "searchIcon", ofType: "png")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("C'est parti !")
                            .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.bodyStyle)
                            .foregroundColor(Color.white)
                 
                    }}, buttonAction: { })
            }
            .padding(25)
            .background(Color.white)
            .cornerRadius(Dimension.sharedInstance.mCornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: Dimension.sharedInstance.mCornerRadius)
                    .stroke(Color.gray, lineWidth: 0.5)
            )
            .padding([.horizontal, .bottom], 25)
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
                Spacer()
                    .frame(height: 100)
            }
            
        }
    }
    
}
