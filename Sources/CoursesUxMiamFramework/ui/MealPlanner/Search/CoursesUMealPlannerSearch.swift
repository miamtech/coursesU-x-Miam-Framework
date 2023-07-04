//
//  MiamBudgetSearch.swift
//  MiamIOSFramework
//
//  Created by Vincent Kergonna on 26/04/2023.
//  Copyright © 2023 Miam. All rights reserved.
//

import SwiftUI
import MiamIOSFramework
import miamCore

@available(iOS 14, *)
public struct CoursesUMealPlannerSearch: MealPlannerSearch {
    public init() {}
    let dimension = Dimension.sharedInstance
    public func content(searchText: Binding<String>, filtersTapped: @escaping () -> Void) -> some View {
        VStack(spacing: 0) {
            HStack(spacing: dimension.mPadding) {
                HStack(spacing: dimension.lPadding) {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .foregroundColor(Color.gray)
                        .frame(width: 20, height: 20)
                    TextField("Rechercher", text: searchText, onCommit: {
                        // TODO: Enter pressed, start searching? Or start searching everytime a char is entered?
                    })
                    .foregroundColor(Color.gray)
                    .frame(maxWidth: .infinity)
                    .autocorrectionDisabled(true)
                    .overlay(
                        HStack {
                            Spacer()
                            if !searchText.wrappedValue.isEmpty {
                                Button(action: {
                                    searchText.wrappedValue = ""
                                }) {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(.gray)
                                        .frame(width: 20, height: 20)
                                }
                                
                            }
                        }
                    )
                }
                .padding(dimension.mPadding)
                
                Divider()
                    .foregroundColor(Color.lightGray)
                Button {
                    filtersTapped()
                } label: {
                    Image(packageResource: "FiltersIcon", ofType: "png")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .padding(.horizontal, dimension.mPadding)
                }
            }
            .padding(.horizontal, dimension.mPadding)
            .background(Color.white)
            .frame(height: 65)
            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(Color.lightGray)
        }
    }
}





@available(iOS 14, *)
struct CoursesUMealPlannerSearch_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.budgetBackgroundColor
            BudgetSearchWrapper()
        }
    }
    
    struct BudgetSearchWrapper: View {
        @SwiftUI.State var text = ""
        
        var body: some View {
            VStack {
                CoursesUMealPlannerSearch().content(searchText: $text, filtersTapped: {})
            }
        }
    }
}
