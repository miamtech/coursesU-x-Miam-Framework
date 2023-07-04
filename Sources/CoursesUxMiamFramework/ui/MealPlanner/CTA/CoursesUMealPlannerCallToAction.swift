//
//  SwiftUIView.swift
//  
//
//  Created by didi on 6/5/23.
//

import SwiftUI
import miamCore
import MiamIOSFramework

@available(iOS 14, *)
public struct CoursesUMealPlannerCallToAction: MealPlannerCallToAction {
   
    public init() {}
    let screen = UIScreen.screenSize
    public func content(onTapGesture: @escaping () -> Void) -> some View {
//        Image(packageResource: "CTAImage", ofType: "png")
        Image(packageResource: "CTAImage", ofType: "png")
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity)
            .padding(Dimension.sharedInstance.mPadding)
            .onTapGesture {
                onTapGesture()
            }
    
    }
}

@available(iOS 14, *)
struct CoursesUMealPlannerCallToAction_Previews: PreviewProvider {
    static var previews: some View {
        CoursesUMealPlannerCallToAction().content {
            print("hello world")
        }
    }
}
