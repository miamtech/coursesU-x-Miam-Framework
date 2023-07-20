//
//  CoursesURecipeDetailsIngredientsView.swift
//  
//
//  Created by didi on 7/6/23.
//
import SwiftUI
import MiamIOSFramework
import miamCore

@available(iOS 14.0, *)
public struct CoursesURecipeDetailsIngredientsView: RecipeDetailsIngredientsViewTemplate {
    
    public init() {}
    
    public func content(infos: RecipeDetailsIngredientsInfos, updateGuestsAction: @escaping (Int) -> Void) -> some View {
        
        if let template = Template.sharedInstance.recipeDetailsIngredientsViewTemplate {
            template(
                infos.ingredients,
                infos.recipeGuests,
                infos.currentGuests,
                infos.guestUpdating,
                updateGuestsAction
            )
        } else {
            HStack {
                HStack {
                    Text("\(infos.ingredients.count) ingrédients")
                        .coursesUFontStyle(style: CoursesUFontStyleProvider().titleStyle)
                        .foregroundColor(Color.black)
                    Spacer()
                }.padding(.horizontal, Dimension.sharedInstance.lPadding)
            }.frame(height: 60.0, alignment: .topLeading)
            Divider()
                .background(Color.miamColor(.borderLight))
                .padding(.horizontal, Dimension.sharedInstance.lPadding)
            
            // Ingredients ListView
            VStack {
                VStack {
                    ForEach(infos.ingredients, id: \.self) { ingredient in
                        if let attributes = ingredient.attributes {
                            let quantity = quantityForIngredient(
                                ingredient,
                                currentNumberOfGuests: infos.currentGuests,
                                recipeNumberOfGuests: infos.recipeGuests)
                            let formattedQuantity = formatQuantity(
                                quantity: quantity,
                                unit: attributes.unit)
                            RecipeDetailsIngredientRow(
                                ingredientName: attributes.name ?? "",
                                quantity: formattedQuantity)
                        }
                    }
                }
                .padding(.vertical, Dimension.sharedInstance.lPadding)
            }
            .background(Color.miamColor(.greyLighter)).cornerRadius(15.0)
            .padding( .horizontal,Dimension.sharedInstance.lPadding)
        }
    }
    
    func formatQuantity(quantity: Float, unit: String?) -> String {
        return QuantityFormatter.default().readableFloatNumber(value: quantity, unit: unit)
    }
    
    func quantityForIngredient(
        _ ingredient: Ingredient,
        currentNumberOfGuests: Int,
        recipeNumberOfGuests: Int
    ) -> Float {
        guard let quantity = ingredient.attributes?.quantity else {
            return 0.0
        }
        
        let realQuantities = QuantityFormatter.default().realQuantities(
            quantity: quantity,
            currentGuest: Int32(currentNumberOfGuests),
            recipeGuest: Int32(recipeNumberOfGuests)
        )
        
        return realQuantities
    }
}

@available(iOS 14.0, *)
struct CoursesURecipeDetailsIngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesURecipeDetailsIngredientsView().content(infos: RecipeDetailsIngredientsInfos(ingredients: [], recipeGuests: 4, currentGuests: 6, guestUpdating: false)) {_ in
        }
    }
}
