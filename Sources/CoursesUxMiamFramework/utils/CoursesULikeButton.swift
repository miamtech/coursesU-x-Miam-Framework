//
//  SwiftUIView.swift
//  
//
//  Created by didi on 6/12/23.
//

import SwiftUI
import MiamIOSFramework


@available(iOS 14, *)
public struct CoursesULikeButton: View {
    private let recipeId: String

    @ObservedObject var viewModel: LikeButtonVM
    public init(recipeId: String) {
        self.recipeId = recipeId
        self.viewModel = LikeButtonVM()
        self.viewModel.setRecipe(recipeId: recipeId)
    }

    public var body: some View {
        HStack {
            if let template = Template.sharedInstance.likeButtonTemplate {
                template(self.viewModel.isLiked, { self.viewModel.toggleLike() })
            } else {
                if let state = viewModel.state {
                    ManagementResourceState(
                        resourceState: state.isLiked,
                        successView: CoursesULikeSuccessView(
                            isSelected:  viewModel.isLiked) {
                                self.viewModel.toggleLike()
                            },
                        loadingView: CoursesULikeSuccessView(isSelected: viewModel.isLiked) {},
                        emptyView: EmptyView())
                }
            }
        }
    }
}



@available(iOS 14, *)
struct CoursesULikeSuccessView: View {
    var isSelected: Bool
        var onButtonPressed: () -> Void
    
    init(isSelected: Bool, onButtonPressed: @escaping () -> Void) {
            self.isSelected = isSelected
            self.onButtonPressed = onButtonPressed
        }

       var body: some View {
           Button(action: {
               self.onButtonPressed()
           }) {
               Image(packageResource: imageName, ofType: "png")
                   .resizable()
                   .foregroundColor(.red)
                   .frame(width: 20, height: 20)
           }
           .padding(Dimension.sharedInstance.mPadding)
           .padding(.leading, imageName == "FilledHeartIcon" ? 2 : 1)
           .buttonStyle(PlainButtonStyle())
           .background(Circle().foregroundColor(.white))
       }

       private var imageName: String {
           if isSelected {
               return "FilledHeartIcon"
           } else {
               return "HeartWithPlusIcon"
           }
       }
}

@available(iOS 14, *)
struct CoursesULikeButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.budgetBackgroundColor
            CoursesULikeButton(recipeId: "23")
        }
       
    }
}
