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
public struct CoursesUInitialBudgetCallToAction: BudgetCallToAction {
   
    public init() {}
    
    public func content(onTapGesture: @escaping () -> Void) -> some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

@available(iOS 14, *)
struct CoursesUInitialBudgetCallToAction_Previews: PreviewProvider {
    static var previews: some View {
        CoursesUInitialBudgetCallToAction().content {
            print("hello world")
        }
    }
}
