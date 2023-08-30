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
    let uuid = UUID()

    @ObservedObject var viewModel: LikeButtonVM = LikeButtonVM()
    public init(recipeId: String) {
        self.recipeId = recipeId
        print("stateMgmt: CoursesULikeButton init \(recipeId) \(uuid)")
//        self.viewModel = LikeButtonVM()
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
        }.onAppear(perform: {
            print("stateMgmt: CoursesULikeButton onAppeared \(recipeId) \(uuid)")
            self.viewModel.setRecipe(recipeId: recipeId)
            viewModel.registerListeners()
        }).onDisappear(perform: {
            viewModel.detach()
            viewModel.dispose()})
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
