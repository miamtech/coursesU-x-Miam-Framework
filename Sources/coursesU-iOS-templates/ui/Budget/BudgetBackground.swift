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
            Image(packageResource: "WhiteWave", ofType: "png")
                .resizable()
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.2)
            Image(packageResource: "BudgetRepasLogo", ofType: "png")
                .resizable()
                .padding(.horizontal, 50)
                .frame(width: UIScreen.screenWidth, height: 100)
                .padding(.top)
                
        }
    }
}

@available(iOS 14, *)
struct BudgetBackground_Previews: PreviewProvider {
    static var previews: some View {
        // when scrolling
        ScrollView {
            ZStack(alignment: .top) {
                Color.budgetBackgroundColor
                BudgetBackground()
                VStack {
                    ForEach(0..<20) { index in
                        Text("Row \(index)")
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .padding(.horizontal)
                    }
                }
                .padding(.top, UIScreen.screenHeight * 0.2)
            }
        }
        
        // when static
        
            ZStack(alignment: .top) {
                Color.budgetBackgroundColor
                BudgetBackground()
                VStack {
                    
                        Text("Stagnant")
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .padding(.horizontal)
                    
                }
                .padding(.top, UIScreen.screenHeight * 0.2)
            
        }
    }
}
