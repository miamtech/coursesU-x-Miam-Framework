//
//  SwiftUIView.swift
//  
//
//  Created by didi on 6/5/23.
//

import SwiftUI

@available(iOS 14, *)
struct BudgetBackground: View {
    var body: some View {
        ZStack(alignment: .top) {
            Color.budgetBackgroundColor
            Image(packageResource: "WhiteWave", ofType: "png")
                .resizable()
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.2)
            Image(packageResource: "BudgetRepasLogo", ofType: "png")
                .padding(.top, UIScreen.screenHeight * 0.05)
        }
    }
}

@available(iOS 14, *)
struct BudgetBackground_Previews: PreviewProvider {
    static var previews: some View {
        BudgetBackground()
    }
}
