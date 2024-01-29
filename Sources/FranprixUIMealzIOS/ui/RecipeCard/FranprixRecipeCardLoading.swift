//
//  FranprixRecipeCardLoading.swift
//  MiamIOSFramework
//
//  Created by Vincent Kergonna on 29/05/2023.
//  Copyright © 2023 Miam. All rights reserved.
//

import SwiftUI
import miamCore
import MiamIOSFramework

@available(iOS 14, *)
public struct FranprixRecipeCardLoading: RecipeCardLoadingProtocol {
        
    let dimensions = Dimension.sharedInstance
    @SwiftUI.State private var opacity: Double = 0.5
    public init() {}
    
    public func content(params: RecipeCardLoadingParameters) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Rectangle()
                .opacity(0.1)
                .frame(height: 150)
//                .background(Color.F.grey2)
                .background(Color.mealzColor(.lightGray))

            
            VStack(alignment: .leading) {
                HStack(alignment: .center, spacing: 20) {
                    HStack {
                        Image(systemName: "clock")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(minWidth: 18, maxWidth: 18, minHeight: 18, maxHeight: 18)
                        Text("...")
                    }
                    
                    HStack {
                        Image(systemName: "person.3")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(minWidth: 24, maxWidth: 24, minHeight: 24, maxHeight: 24)
                        Text("......")
                    }
                    
                    HStack {
                        Image("miamCookHat")
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(minWidth: 18, maxWidth: 18, minHeight: 18, maxHeight: 18)
                        Text("...")
                    }
                }
                .foregroundColor(Color.mealzColor(.lighterGray))
//                .foregroundColor(Color.F.grey1)
//                .font(.lexend(.medium, 12))

                Text(".............")
                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .font(.lexend(.semiBold, 16))
            }
            .padding(EdgeInsets(top: 12, leading: 12, bottom: 20, trailing: 12))
            
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
//                .shadow(radius: 12)
        .redacted(reason: .placeholder).opacity(0.25)
        .transition(.opacity).onAppear {
            let baseAnimation = Animation.easeInOut(duration: 1.0)
            let repeated = baseAnimation.repeatForever(autoreverses: true)
            withAnimation(repeated) {
                self.opacity = 1.0
            }
        }
    }
}

@available(iOS 14, *)
struct FranprixRecipeCardLoading_Previews: PreviewProvider {
    static var previews: some View {
        FranprixRecipeCardLoading().content(params: RecipeCardLoadingParameters(recipeCardDimensions: CGSize(width: 300, height: 300)))
    }
}
