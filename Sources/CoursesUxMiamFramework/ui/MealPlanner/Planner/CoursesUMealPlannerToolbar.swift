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
public struct CoursesUMealPlannerToolbar: MealPlannerResultsToolbarProtocol {
    let dimension = Dimension.sharedInstance
    public init() {}
    public func content(params: MealPlannerResultsToolbarParameters) -> some View {
         HStack {
             CoursesUFormRow(
                caption: params.mealPlannerCriteria.availableBudget.wrappedValue.currencyFormatted,
                icon: Image(packageResource: "BudgetIcon", ofType: "png"),
                content: Spacer().frame(width: 0))
                .frame(minWidth: 110)
            Divider()
             CoursesUFormRow(
                caption: String(params.mealPlannerCriteria.numberOfGuests.wrappedValue),
                icon: Image(packageResource: "numberOfPeopleIcon", ofType: "png"),
                content: Spacer().frame(width: 0))
            Divider()
             CoursesUFormRow(
                caption: String(params.mealPlannerCriteria.numberOfMeals.wrappedValue),
                icon: Image(packageResource: "numberOfMealsIcon", ofType: "png"),
                content: Spacer().frame(width: 0))
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
struct CoursesUMealPlannerToolbar_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }

    struct Preview: View {
        @SwiftUI.State var loading = false
        @SwiftUI.State var mealPlannerCriteria = MealPlannerCriteria(
            availableBudget: 30.0,
            numberOfGuests: 4,
            numberOfMeals: 4)
        var body: some View {
            CoursesUMealPlannerToolbar().content(
                params: MealPlannerResultsToolbarParameters(
                mealPlannerCriteria: $mealPlannerCriteria,
                activelyEditingTextField: .constant(false),
                isLoadingRecipes: $loading,
                onValidateTapped: {})
                )
        }
    }
}
