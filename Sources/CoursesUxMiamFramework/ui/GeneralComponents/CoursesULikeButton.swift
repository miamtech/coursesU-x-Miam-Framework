//
//  CoursesULikeButton.swift
//  
//
//  Created by didi on 6/12/23.
//

import SwiftUI
import MiamIOSFramework

@available(iOS 14, *)
public struct CoursesULikeButton: View {
    private let recipeId: String
    public init(recipeId: String) {
        self.recipeId = recipeId
    }
    public var body: some View {
        LikeButton(likeButtonInfo: LikeButtonInfo(
            recipeId: recipeId
        ))
        .background(Circle().foregroundColor(Color.white))
    }
}

@available(iOS 14, *)
#Preview {
    CoursesULikeButton(recipeId: "")
}
