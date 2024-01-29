//
//  FranprixFavoritesEmpty.swift
//
//
//  Created by Diarmuid McGonagle on 29/01/2024.
//

import SwiftUI
import MiamIOSFramework

// pass in self.userService.isConnected for isSignedIn

@available(iOS 14, *)
public struct FranprixFavoritesEmpty: EmptyProtocol {
    private let isSignedIn: Bool
    public init(isSignedIn: Bool) {
        self.isSignedIn = isSignedIn
    }
    public func content(params: BaseEmptyParameters) -> some View {
        VStack(spacing: 20) {
            Image(isSignedIn ? "empty-recipe" : "icon-heart-color-2")
            if !isSignedIn {
                Text("Pas encore connecté ?")
//                    .font(.lexend(.semiBold, 18))
//                    .foregroundColor(Color.F.black)
                    .foregroundColor(Color.mealzColor(.darkestGray))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }
            Text(isSignedIn
                 ? "Vous n’avez pas encore de recettes favorites, on peut vous aider ?!"
                 : "Une fois connecté retrouvez ici vos recettes favorites 😀")
//            .font(.lexend(.semiBold, 14))
//            .foregroundColor(Color.F.black)
            .foregroundColor(Color.mealzColor(.darkestGray))
            .multilineTextAlignment(.center)
            .padding(.horizontal, 40)
            VStack {
                Button {
                    (params.onOptionalCallback ?? {})()
                } label: {
                    Text(isSignedIn
                         ? "Je découvre les recettes"
                         : "Me connecter")
//                    .font(.lexend(.semiBold, 14))
//                    .foregroundColor(Color.F.white)
                    .foregroundColor(Color.mealzColor(.white))
                    .padding(.horizontal, 20)
                    .frame(height: 44)
                    .frame(maxWidth: .infinity)
//                    .background(Color.F.orange)
                    .background(Color.mealzColor(.primary))
                    .clipShape(Capsule())
                }
            }
            .padding(.horizontal, 20)
            
        }
    }
}

@available(iOS 14, *)
struct FranprixFavoritesEmpty_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FranprixFavoritesEmpty(isSignedIn: true).content(params: BaseEmptyParameters(onOptionalCallback: {}))
                .previewDisplayName("signed in")
            FranprixFavoritesEmpty(isSignedIn: false).content(params: BaseEmptyParameters(onOptionalCallback: {}))
                .previewDisplayName("signed out")
        }
    }
}
