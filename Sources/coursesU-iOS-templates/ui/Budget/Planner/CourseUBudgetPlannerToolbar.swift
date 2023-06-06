//
//  SwiftUIView.swift
//
//
//  Created by didi on 6/6/23.
//

//
//  MiamBudgetPlannerToolbar.swift
//  MiamIOSFramework
//
//  Created by Vincent Kergonna on 26/04/2023.
//  Copyright © 2023 Miam. All rights reserved.
//

import SwiftUI
import miamCore
import MiamIOSFramework

@available(iOS 14, *)
public struct CourseUBudgetPlannerToolbar: BudgetPlannerToolbar {
    @SwiftUI.State var budget = 23.0
    @SwiftUI.State var numberGuests = 4
    @SwiftUI.State var numberMeals = 4
    let dimension = Dimension.sharedInstance
    public init() {}
    public func content(budgetInfos: BudgetInfos,
                        isLoadingRecipes: Binding<Bool>,
                        onValidateTapped: @escaping (BudgetInfos) -> Void) -> some View {
        HStack {
//            MealPlannerBudget(
//                defaultValue: budgetInfos.moneyBudget,
//                currency: Localization.price.currency.localised) { money in
//                onValidateTapped(
//                    BudgetInfos(
//                        moneyBudget: money,
//                        numberOfGuests: budgetInfos.numberOfGuests,
//                        numberOfMeals: budgetInfos.numberOfMeals)
//                )
//            }
            Divider()
            CoursesUStepperCollapsed(
                defaultValue: budgetInfos.numberOfGuests,
                icon: Image(packageResource: "numberOfPeopleIcon", ofType: "png")) { guests in
                onValidateTapped(
                    BudgetInfos(
                        moneyBudget: budgetInfos.moneyBudget,
                        numberOfGuests: guests,
                        numberOfMeals: budgetInfos.numberOfMeals)
                )
            }
            Divider()
            CoursesUStepperCollapsed(
                defaultValue: budgetInfos.numberOfMeals,
                icon: Image(packageResource: "numberOfMealsIcon", ofType: "png")) { meals in
                onValidateTapped(
                    BudgetInfos(
                        moneyBudget: budgetInfos.moneyBudget,
                        numberOfGuests: budgetInfos.numberOfGuests,
                        numberOfMeals: meals)
                )
            }
            SubmitButtonCollapsed(isLoading: isLoadingRecipes) {
                let infos = BudgetInfos(moneyBudget: budget, numberOfGuests: numberGuests, numberOfMeals: numberMeals)
                onValidateTapped(infos)
            }
        }
    }
}

@available (iOS 14, *)
internal struct SubmitButtonCollapsed: View {
    @Binding var isLoading: Bool
    let buttonAction: () -> Void
    let dimension = Dimension.sharedInstance
    var body: some View {
        Button {
            withAnimation {
                isLoading.toggle()
                buttonAction()
            }
        } label: {
            if isLoading {
                ProgressLoader(color: .white)
                    .scaleEffect(0.5)
            } else {
                Image(packageResource: "EditPencilIcon", ofType: "png")
                    .resizable()
                    .foregroundColor(Color.white)
                    .frame(width: dimension.mButtonHeight, height: dimension.mButtonHeight)
            }
        }
        .padding()
        .background(Color.primaryColor)
        .clipShape(Circle())
    }
}

@available(iOS 14, *)
struct CourseUBudgetPlannerToolbar_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }

    struct Preview: View {
        @SwiftUI.State var loading = false
        var body: some View {
            CourseUBudgetPlannerToolbar().content(budgetInfos: BudgetInfos(moneyBudget: 20.0, numberOfGuests: 4, numberOfMeals: 4),
                                               isLoadingRecipes: $loading, onValidateTapped: {_ in})
        }
    }
}
