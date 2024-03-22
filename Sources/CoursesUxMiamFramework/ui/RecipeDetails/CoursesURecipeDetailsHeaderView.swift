//
//  CoursesURecipeDetailsHeaderView.swift
//
//
//  Created by miam x didi on 22/02/2024.
//

import SwiftUI
import MiamIOSFramework

@available(iOS 14, *)
public struct CoursesURecipeDetailsHeaderView: RecipeDetailsHeaderProtocol {
    public init() {}
    let imageHeight:CGFloat = (UIScreen.screenHeight > 900) ? 400 : 300
    public func content(params: RecipeDetailsHeaderParameters) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    /*Button {
                        params.onRecipeDetailsClosed()
                    } label: {
                        Image.mealzIcon(icon: .caret)
                            .renderingMode(.template)
                            .rotationEffect(Angle(degrees: 180))
                    }.frame(width: 40, height: 40)
                        .foregroundColor(Color.mealzColor(.primary))
                        .background(Color.white)
                        .clipShape(Circle()).padding()
                     */
                    Spacer()
                    LikeButton(likeButtonInfo: LikeButtonInfo(recipeId: params.recipeId)).padding(16)
                }
                Spacer()
                if !params.isForMealPlanner {
                    RecipeDetailsGuestCount(
                        currentGuests: params.currentGuests,
                        updateGuest: params.onUpdateGuests
                    )
                }
            }
            .background(
                mediaImageView(mediaURL: params.mediaURL)
                    .frame(height: imageHeight),
                alignment: .top)
            .frame(maxWidth: .infinity)
            .frame(height: imageHeight)
            Text(params.title)
                .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.titleStyle)
                .padding(.bottom, Dimension.sharedInstance.sPadding)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            CoursesURecipeDetailsTagsView(tags: params.tags)
        }
    }
    
    internal struct RecipeDetailsGuestCount: View {
        private let currentGuests: Int
        private let updateGuest: (Int) -> Void
        init(currentGuests: Int, updateGuest: @escaping (Int) -> Void) {
            self.currentGuests = currentGuests
            self.updateGuest = updateGuest
        }
        public var body: some View {
            HStack{
                Spacer()
                HStack{
                    Button {
                        updateGuest(max((currentGuests - 1), 1))
                    } label: {
                        Image.mealzIcon(icon: .minus)
                            .renderingMode(.template).foregroundColor(Color.mealzColor(.primary))
                    }
                    Text("\(currentGuests)")
                        .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodyBigBoldStyle)
                        .frame(minWidth: 10, alignment: .center)
                        .foregroundColor(Color.mealzColor(.darkestGray))
                    Image.mealzIcon(icon: .guests)
                        .renderingMode(.template)
                        .foregroundColor(Color.mealzColor(.darkestGray))
                    Button {
                        updateGuest(currentGuests + 1)
                    } label: {
                        Image.mealzIcon(icon: .plus)
                            .renderingMode(.template).foregroundColor(Color.mealzColor(.primary))
                    }
                }
                .padding(Dimension.sharedInstance.mlPadding)
                .background(Capsule().foregroundColor(Color.white))
                .padding(Dimension.sharedInstance.lPadding)
            }
        }
    }
    
    @ViewBuilder
    private func mediaImageView(mediaURL: String?) -> some View {
        if let urlString = mediaURL, let url = URL(string: urlString) {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: imageHeight)
                    .clipped()
            }
        } else {
            Image.mealzIcon(icon: .pan)
        }
    }
    
}
