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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

@available(iOS 14, *)
struct CoursesUBudgetForm_Previews: PreviewProvider {
    static var previews: some View {
        CoursesUBudgetForm().content(isFetchingRecipes: false, onBudgetChanged: { budgetInfos in
            print("Budget changed: \(budgetInfos)")
        }, onFormValidated: { _ in })
    }
}
