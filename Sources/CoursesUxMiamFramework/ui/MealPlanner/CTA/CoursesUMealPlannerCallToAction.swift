//
//  SwiftUIView.swift
//  
//
//  Created by didi on 6/5/23.
//

import SwiftUI
import mealzcore
import MealziOSSDK

@available(iOS 14, *)
public struct CoursesUMealPlannerCallToAction: MealPlannerCTAProtocol {
    public init() {}
    let screen = UIScreen.screenSize
    public func content(params: MealPlannerCTAViewParameters) -> some View {
        MealzMealPlannerCallToAction().content(params: params)
    }
}

@available(iOS 14, *)
struct CoursesUMealPlannerCallToAction_Previews: PreviewProvider {
    static var previews: some View {
        CoursesUMealPlannerCallToAction().content(params: MealPlannerCTAViewParameters() { route in
            print("Click on Planner CTA to redirect to \(route)")
        })
    }
}
