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
public struct CoursesUBudgetPlannerToolbar: BudgetPlannerToolbar {
    @SwiftUI.State var budget = 23.0
    @SwiftUI.State var numberGuests = 4
    @SwiftUI.State var numberMeals = 4
    let dimension = Dimension.sharedInstance
    public init() {}
    public func content(budgetInfos: BudgetInfos,
                        isLoadingRecipes: Binding<Bool>,
                        onValidateTapped: @escaping (BudgetInfos) -> Void) -> some View {
        HStack {
            Spacer()
            CoursesUFormRow(caption: String(Int(budget)), icon: Image(packageResource: "BudgetIcon", ofType: "png"), content: Spacer().frame(width: 0))
//            CoursesUInputWithIcon(
//                defaultValue: budgetInfos.moneyBudget,
//                icon: Image(packageResource: "BudgetIcon", ofType: "png")
//               ) { money in
//                onValidateTapped(
//                    BudgetInfos(
//                        moneyBudget: money,
//                        numberOfGuests: budgetInfos.numberOfGuests,
//                        numberOfMeals: budgetInfos.numberOfMeals)
//                )
//            }
            Divider()
            CoursesUFormRow(caption: String(numberGuests), icon: Image(packageResource: "numberOfPeopleIcon", ofType: "png"), content: Spacer().frame(width: 0))
            Divider()
            CoursesUFormRow(caption: String(numberMeals),icon: Image(packageResource: "numberOfMealsIcon", ofType: "png"), content: Spacer().frame(width: 0))
            
        }
        .padding(.vertical, 5)
        .padding(.leading)
        .padding(.trailing, 1)
        .background(Color.white)
        .frame(height: 60)
        .cornerRadius(dimension.xlCornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: Dimension.sharedInstance.xlCornerRadius)
                .stroke(Color.gray, lineWidth: 0.5)
        )
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
                    .frame(width: 25, height: 25)
                    .padding()
            }
        }
        
        .background(Color.primaryColor)
        .clipShape(Circle())
    }
}

@available(iOS 14, *)
struct CoursesUBudgetPlannerToolbar_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }

    struct Preview: View {
        @SwiftUI.State var loading = false
        var body: some View {
            ZStack{
                Color.budgetBackgroundColor
                VStack(spacing: -40.0) {
                    BudgetBackground()
                    CoursesUBudgetPlannerToolbar().content(budgetInfos: BudgetInfos(moneyBudget: 20.0, numberOfGuests: 4, numberOfMeals: 4),
                                                       isLoadingRecipes: $loading, onValidateTapped: {_ in})
                    .padding()
                    Spacer()
                }
                
            }
            
        }
    }
}
