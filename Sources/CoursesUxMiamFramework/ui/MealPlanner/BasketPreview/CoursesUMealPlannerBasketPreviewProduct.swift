//
//  SwiftUIView.swift
//  
//
//  Created by didi on 6/16/23.
//

import SwiftUI
import MiamIOSFramework
import miamCore


@available(iOS 14, *)
public struct CoursesUMealPlannerBasketPreviewProduct: MealPlannerBasketPreviewProduct {
    
    public init () {}
    let dimension = Dimension.sharedInstance
    public func content(
        quantity: Binding<Int>,
        productInfo: MealPlannerBasketPreviewProductInfos,
        actions: MealPlannerBudgetPreviewProductActions) -> some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                AsyncImage(url: productInfo.pictureURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(0)
                        .frame(width: 60)
                }
                .frame(width: 75.0)
                VStack(alignment: .leading) {
                    if productInfo.sharedRecipeCount > 1 {
                        UtilizedInManyRecipes(recipesUsedIn: productInfo.sharedRecipeCount)
                    }
                    Text(productInfo.name)
                        .foregroundColor(Color.black)
                        .coursesUFontStyle(style: CoursesUFontStyleProvider().subtitleStyle)
                    Text(productInfo.description)
                        .foregroundColor(Color.gray)
                        .coursesUFontStyle(style: CoursesUFontStyleProvider().bodyStyle)
                    if productInfo.isSubstitutable {
                        Button {
                            actions.changeProduct()
                        } label: {
                            Text("Changer d'article")
                                .underline()
                                .foregroundColor(Color.primaryColor)
                                .coursesUFontStyle(style: CoursesUFontStyleProvider().bodyBigStyle)
                                .padding(.vertical, dimension.sPadding)
                        }
                        Spacer()
                    }
                    HStack() {
                        Text("\(productInfo.price.formattedPrice())")
                            .foregroundColor(Color.black)
                            .coursesUFontStyle(style: CoursesUFontStyleProvider().titleStyle)
                        Spacer()
                        CoursesUCounterView(count: quantity)
                        Spacer()
                        TrashButton {
                            actions.delete()
                        }
                        
                    }
                    .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)
            }
            .frame(height: 170)
            .padding(dimension.mPadding)
            .background(Color.white)
        }
    }
    
    struct TrashButton: View {
        var delete: () -> Void
        @SwiftUI.State var loading = false
        let dimension = Dimension.sharedInstance
        var body: some View {
            Button {
                loading.toggle()
                delete()
            } label: {
                VStack {
                    if loading {
                        ProgressLoader(color: Color.primaryColor)
                            .scaleEffect(0.25)
                    } else {
                        Image(packageResource: "TrashIcon", ofType: "png")
                            .resizable()
                            .frame(width: dimension.mlButtonHeight, height: dimension.mlButtonHeight)
                    }
                }.frame(width: dimension.mlButtonHeight, height: dimension.mlButtonHeight)
                    .padding(dimension.mPadding)
            }
        }
    }
    
    struct UtilizedInManyRecipes: View {
        var recipesUsedIn: Int
        let dimension = Dimension.sharedInstance
        var body: some View {
            HStack(spacing: 0) {
                Image(packageResource: "numberOfMealsIcon", ofType: "png")
                    .resizable()
                    .renderingMode(.template) // Makes the image a template
                                    .foregroundColor(.black)
                    .frame(width: dimension.mButtonHeight, height: dimension.mButtonHeight)
                    .padding(dimension.sPadding)
                Text("Utilisé dans \(recipesUsedIn) repas")
                    .foregroundColor(Color.gray)
                    .coursesUFontStyle(style: CoursesUFontStyleProvider().bodySmallStyle)
            }
            .padding(.trailing, dimension.mPadding)
            .background(Color.lightGray)
            .clipShape(RoundedRectangle(cornerRadius: dimension.sCornerRadius, style: .continuous)) // Replace with your corner size
        }
    }
    
    
}

@available(iOS 14, *)
struct CoursesUMealPlannerBasketPreviewProduct_Previews: PreviewProvider {
    static var previews: some View {
        CoursesUMealPlannerBasketPreviewProduct().content(quantity: .constant(4), productInfo: MealPlannerBasketPreviewProductInfos(price: Price(price: 4, currency: "EUR"), name: "Tom's Saunce", description: "Sauce!", pictureURL: URL(string: "https://picsum.photos/200/300")!, sharedRecipeCount: 3, isSubstitutable: false, pricePerUnit: Price(price: 2, currency: "EUR"), unit: "12kg"), actions: MealPlannerBudgetPreviewProductActions(delete: {}, changeProduct: {}))
        
        ZStack {
            Color.budgetBackgroundColor
            VStack {
                CoursesUMealPlannerBasketPreviewProduct().content(quantity: .constant(4), productInfo: MealPlannerBasketPreviewProductInfos(price: Price(price: 4, currency: "EUR"), name: "Tom's Saune", description: "Sauce!", pictureURL: URL(string: "https://picsum.photos/200/300")!, sharedRecipeCount: 3, isSubstitutable: false, pricePerUnit: Price(price: 4, currency: "EUR"), unit: "12kg"), actions: MealPlannerBudgetPreviewProductActions(delete: {}, changeProduct: {}))
                Divider()
                CoursesUMealPlannerBasketPreviewProduct().content(quantity: .constant(4), productInfo: MealPlannerBasketPreviewProductInfos(price: Price(price: 4, currency: "EUR"), name: "Kevin's Pinapple", description: "Pineapple!", pictureURL: URL(string: "https://picsum.photos/200/300")!, sharedRecipeCount: 3, isSubstitutable: true, pricePerUnit: Price(price: 4, currency: "EUR"), unit: "12kg"), actions: MealPlannerBudgetPreviewProductActions(delete: {}, changeProduct: {}))
                Divider()
                CoursesUMealPlannerBasketPreviewProduct().content(quantity: .constant(4), productInfo: MealPlannerBasketPreviewProductInfos(price: Price(price: 4, currency: "EUR"), name: "Tibo's Strawberry", description: "Strawberry!", pictureURL: URL(string: "https://picsum.photos/200/300")!, sharedRecipeCount: 0, isSubstitutable: false, pricePerUnit: Price(price: 4, currency: "EUR"), unit: "12kg"), actions: MealPlannerBudgetPreviewProductActions(delete: {}, changeProduct: {}))
            }
            .padding()
            .background(Color.white)
            .padding(.horizontal)
        }
    }
}
