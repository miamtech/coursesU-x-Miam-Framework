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
   
    public func content(quantity: Binding<Int>, productInfo: MealPlannerBasketPreviewProductInfos, actions: MealPlannerBudgetPreviewProductActions) -> some View {
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
                if productInfo.sharedRecipeCount > 0 {
                    UtilizedInManyRecipes(recipesUsedIn: productInfo.sharedRecipeCount)
                }
                Text(productInfo.name)
                    .foregroundColor(Color.black)
                    .coursesUFontStyle(style: CoursesUFontStyleProvider().subtitleStyle)
                Text(productInfo.description)
                    .foregroundColor(Color.gray)
                    .coursesUFontStyle(style: CoursesUFontStyleProvider().bodyStyle)
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
                HStack() {
                    Text("\(productInfo.price.formattedPrice())")
                        .foregroundColor(Color.black)
                        .coursesUFontStyle(style: CoursesUFontStyleProvider().titleStyle)
                    Spacer()
                    CoursesUCounterView(count: quantity)
                    Spacer()
                    Button {
                        actions.delete()
                    } label: {
                        Image(systemName: "trash")
                            .resizable()
                            .foregroundColor(Color.black)
                            .frame(width: dimension.mButtonHeight, height: dimension.mlButtonHeight)
                            .padding(dimension.mPadding)
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
    
    
    
    struct NotAvailable: View {
        var name: String
        var body: some View {
            VStack {
                HStack {
                    Text("\(name)")
                        .foregroundColor(Color.gray)
                        .coursesUFontStyle(style: CoursesUFontStyleProvider().subtitleStyle)
                    Spacer()
                }
                Text("Indisponible")
                    .foregroundColor(Color.gray)
                    .coursesUFontStyle(style: CoursesUFontStyleProvider().subtitleStyle)
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
    
    @available(iOS 14, *)
    public struct CoursesUCounterView: View {

        @Binding public var count: Int
//        public var onCounterChanged: (Int) -> Void
        public var maxValue: Int?
        public var minValue: Int?
        public var isLoading: Bool
        public var isDisable: Bool

//        public init(
//            count: Int,
//            onCounterChanged: @escaping (Int) -> Void
//        ) {
//            self.onCounterChanged = onCounterChanged
//            self._count = State(initialValue: count)
//        }
        
        init(count: Binding<Int>, maxValue: Int? = nil, minValue: Int? = nil, isLoading: Bool = false, isDisable: Bool = false) {
            _count = count
            self.maxValue = maxValue
            self.minValue = minValue
            self.isLoading = isLoading
            self.isDisable = isDisable
        }

        private func newValueBounded(newValue: Int) -> Bool {
            guard let minValue, let maxValue else {
                return true
            }
            return newValue >= minValue && newValue <= maxValue
        }

        private func increase() {
            if !newValueBounded(newValue: count + 1) { return }
            count += 1
        }

        private  func decrease() {
            if !newValueBounded(newValue: count - 1) { return }
            count -= 1
        }

        public var body: some View {
//            if let template = Template.sharedInstance.counterViewTemplate {
//                template(count, {increase()}(), {decrease()})
//            } else {
                HStack {
                    Button {
                        decrease()
                    } label: {
                        Image(systemName: "minus")
                            .resizable()
                            .frame(width: 12, height: 2)
                            .foregroundColor(Color.black)
                            .padding(Dimension.sharedInstance.lPadding)
                    }
                    .frame(width: 20.0, height: 20.0, alignment: .leading)
                    .disabled(self.isDisable)

                    Spacer()
                    if isLoading {
                        ProgressLoader(color: Color.white)
                            .scaleEffect(0.5)
                    } else {
                        Text("\(count)")
                            .coursesUFontStyle(style: CoursesUFontStyleProvider().bodyBoldStyle)
                            .foregroundColor(Color.black)
                        Spacer()
                    }
                    Button {
                       increase()
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 12, height: 12)
                            .foregroundColor(Color.black)
                            .padding(Dimension.sharedInstance.lPadding)
                    }
                    
                    .frame(width: 20.0, height: 20.0, alignment: .trailing)
                    .disabled(self.isDisable)

                }.frame(width: 100.0, height: 40.0, alignment: .center)
                    .background(Color.lightGray)
                    .cornerRadius(25.0)
                    
                    .overlay(
                        RoundedRectangle(cornerRadius: 25.0)
                            .stroke(Color.gray, lineWidth: 0.5)
                    )
                    .padding( Dimension.sharedInstance.mPadding)

                
//            }
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
