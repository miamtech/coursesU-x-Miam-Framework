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
struct CoursesUMealPlannerBasketPreviewProduct: MealPlannerBasketPreviewProduct {
    var ingridient: Ingredient
    let dimension = Dimension.sharedInstance
    func content() -> some View {
        HStack(alignment: .top) {
            AsyncImage(url: ingridient.pictureURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(0)
                    .frame(width: 60)
            }
            .frame(width: 75.0)
            VStack(alignment: .leading) {
//                if ingridient.quantity > 0 {
                UtilizedInManyRecipes(recipesUsedIn: 3)
//                }
                Text(ingridient.name)
                    .foregroundColor(Color.black)
                    .coursesUFontStyle(style: CoursesUFontStyleProvider().subtitleStyle)
                Text(ingridient.unit)
                    .foregroundColor(Color.gray)
                    .coursesUFontStyle(style: CoursesUFontStyleProvider().bodyStyle)
                Button {
                    print("change")
                } label: {
                    Text("Changer d'article")
                        .underline()
                        .foregroundColor(Color.primaryColor)
                        .coursesUFontStyle(style: CoursesUFontStyleProvider().bodyBigStyle)
                        .padding(.vertical, dimension.sPadding)
                }
                Spacer()
                HStack() {
                    Text("\(ingridient.quantity) €")
                        .foregroundColor(Color.black)
                        .coursesUFontStyle(style: CoursesUFontStyleProvider().titleStyle)
                    Spacer()
                    CoursesUCounterView(count: 4, onCounterChanged: {_ in })
                    Spacer()
                    Image(systemName: "trash")
                        .resizable()
                        .frame(width: dimension.mButtonHeight, height: dimension.mlButtonHeight)
                        .padding(dimension.mPadding)
                        .onTapGesture {
                            print("delete")
                        }
                }
                .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
        }
        .frame(height: 185)
        .padding(dimension.mPadding)
        .background(Color.white)
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

        @SwiftUI.State public var count: Int
        public var onCounterChanged: (Int) -> Void
        public var lightMode: Bool = false
        public var maxValue: Int?
        public var minValue: Int?
        public var isLoading: Bool = false
        public var isDisable: Bool = false

        public init(
            count: Int,
            onCounterChanged: @escaping (Int) -> Void
        ) {
            self.onCounterChanged = onCounterChanged
            self._count = State(initialValue: count)
        }

        public init(
            count: Int,
            lightMode: Bool,
            onCounterChanged: @escaping (Int) -> Void
        ) {

            self.lightMode = lightMode
            self.onCounterChanged = onCounterChanged
            self._count = State(initialValue: count)
        }

        public init(
            count: Int,
            lightMode: Bool,
            onCounterChanged: @escaping (Int) -> Void,
            isLoading: Bool = false,
            isDisable: Bool = false,
            minValue: Int? = nil,
            maxValue: Int? = nil
        ) {
            self.lightMode = lightMode
            self.onCounterChanged = onCounterChanged
            self.minValue = minValue ?? nil
            self.maxValue = maxValue ?? nil
            self.isLoading = isLoading
            self.isDisable = isDisable
            self._count = State(initialValue: count)
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
            onCounterChanged(count)
        }

        private  func decrease() {
            if !newValueBounded(newValue: count - 1) { return }
            count -= 1
            onCounterChanged(count)
        }

        public var body: some View {
            if let template = Template.sharedInstance.counterViewTemplate {
                template(count, lightMode, {increase()}, {decrease()})
            } else {
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

                
            }
        }
    }

}

@available(iOS 14, *)
struct CoursesUMealPlannerBasketPreviewProduct_Previews: PreviewProvider {
    static var previews: some View {
        CoursesUMealPlannerBasketPreviewProduct(ingridient: FakeIngredient().createRandomFakeRecipe()).content()
    }
}
