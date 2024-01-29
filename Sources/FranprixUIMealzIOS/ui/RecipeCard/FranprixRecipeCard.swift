//
//  FranprixRecipeCard.swift
//  MiamIOSFramework
//
//  Created by Vincent Kergonna on 26/05/2023.
//  Copyright © 2023 Miam. All rights reserved.
//

import SwiftUI
import miamCore
import MiamIOSFramework

@available(iOS 14, *)
public struct FranprixRecipeCard: CatalogRecipeCardProtocol {
    public init() {}
    public func content(params: CatalogRecipeCardParameters) -> some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                ZStack {
                    if let mediaUrlString = params.recipe.attributes?.mediaUrl,
                       let mediaUrl = URL(string: mediaUrlString) {
                        AsyncImage(url: mediaUrl) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(minWidth: 0, maxWidth: .infinity)
                        }
                        .clipped()
                        .onTapGesture {
                            params.onShowRecipeDetails(params.recipe.id)
                        }
                    }
                    VStack {
                        Spacer().frame(height: 60)
                        HStack {
                            Spacer()
                            LikeButton(likeButtonInfo: LikeButtonInfo(recipeId: params.recipe.id))
                            Spacer().frame(width: 8)
                        }
                        Spacer()
                    }
                }
                .frame(height: 150)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                VStack(alignment: .leading) {
                    HStack(alignment: .center, spacing: 20) {
                        HStack {
                            Image(systemName: "clock")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(minWidth: 18, maxWidth: 18, minHeight: 18, maxHeight: 18)
                            Text(params.recipe.totalTime)
                                .lineLimit(2)
                        }
                        
                        HStack {
                            Image(systemName: "person.3")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(minWidth: 24, maxWidth: 24, minHeight: 24, maxHeight: 24)
                            Text("\(params.recipe.attributes?.numberOfGuests ?? 3) Personnes")
                                .lineLimit(2)
                                .minimumScaleFactor(0.6)
                        }
                        
                        switch params.recipe.attributes?.difficulty {
                        case 1: Text(Localization.recipe.lowDifficulty.localised)
                        case 2: Text(Localization.recipe.mediumDifficulty.localised)
                        case 3: Text(Localization.recipe.highDifficulty.localised)
                        default: Text(Localization.recipe.lowDifficulty.localised)
                        }
                    }
                    //                    .foregroundColor(Color.F.grey1)
                    .foregroundColor(Color.mealzColor(.lighterGray))
                    //                    .font(.lexend(.medium, 12))
                    
                    Text("\(params.recipe.attributes?.title ?? "Titre")")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    //                        .font(.lexend(.semiBold, 16))
                        .lineLimit(2)
                }
                .padding(EdgeInsets(top: 12, leading: 12, bottom: 20, trailing: 12))
            }
            .frame(width: params.recipeCardDimensions.width, height: params.recipeCardDimensions.height)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        }
    }
}

@available(iOS 14, *)
struct FranprixRecipeCard_Previews: PreviewProvider {
    static var previews: some View {
        let recipe = RecipeFakeFactory().create(
            id: RecipeFakeFactory().FAKE_ID,
            attributes: RecipeFakeFactory().createAttributes(
                title: "Parmentier de Poulet",
                mediaUrl: "https://picsum.photos/200/300"),
            relationships: nil)
        ZStack {
            Color.budgetBackgroundColor
            FranprixRecipeCard()
                .content(
                    params: CatalogRecipeCardParameters(
                        recipeCardDimensions: CGSize(width: 320, height: 300),
                        recipe: recipe,
                        recipePrice: 12.4,
                        numberOfGuests: 4,
                        isCurrentlyInBasket: false,
                        onAddToBasket: {_ in },
                        onShowRecipeDetails: {_ in}
                    )
                )
                .padding(80.0)
        }
        
    }
}
