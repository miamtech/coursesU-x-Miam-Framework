//
//  SwiftUIView.swift
//  
//
//  Created by didi on 6/6/23.
//

import SwiftUI
import miamCore
import MiamIOSFramework

@available(iOS 14, *)
struct CoursesUBudgetFormStandaloneWrapper: View {
    @SwiftUI.State var budget = 0.0
    @SwiftUI.State var numberGuests = 0
    @SwiftUI.State var numberMeals = 0
    var body: some View {
        CoursesUBudgetForm(budget: $budget, numberGuests: $numberGuests, numberMeals: $numberMeals).content(isFetchingRecipes: false, onBudgetChanged: {_ in}, onFormValidated: {_ in})
    }
}

@available(iOS 14, *)
public struct CoursesUBudgetForm: BudgetForm {
    var includeTitle: Bool
    var includeBackground: Bool
    @Binding var budget: Double
    @Binding var numberGuests: Int
    @Binding var numberMeals: Int
    let dimension = Dimension.sharedInstance
    public init(includeTitle: Bool = true, includeBackground: Bool = true, budget: Binding<Double>, numberGuests: Binding<Int>, numberMeals: Binding<Int>) {
        self.includeTitle = includeTitle
        self.includeBackground = includeBackground
        _budget = budget
        _numberGuests = numberGuests
        _numberMeals = numberMeals
    }
      
    var budgetAndGuestsValid: Bool {
        return budget > 0.0 && numberGuests > 0
    }
    
    public func content(budgetInfos: BudgetInfos? = nil, isFetchingRecipes: Bool, onBudgetChanged: @escaping (BudgetInfos) -> Void, onFormValidated: @escaping (BudgetInfos) -> Void) -> some View {
        ZStack(alignment: .top) {
            if includeBackground {
                CoursesUTwoMealsBackground()
            }
            VStack(spacing: 20) {
                if includeTitle {
                    VStack {
                        Text("Choissez vos repas de la semaine ou du mois selon votre budget :")
                            .multilineTextAlignment(.center)
                            .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.bodyBigBoldStyle)
                            .padding(.bottom, dimension.mPadding)
                        Divider()
                    }
                }
                
                // TODO: localize
                CoursesUFormRow(
                    caption: "Mon budget max",
                    icon: Image(packageResource: "BudgetIcon", ofType: "png"),
                    content:
                        HStack {
                            Spacer()
                            CoursesUInputWithCurrency(budget: $budget, onInputChanged: { number in
                                budget = number
//                                checkBudgetAndGuests()
                            })
                        }
                        .padding(dimension.mPadding)

                )
                Divider()
                // TODO: localize
//                CoursesUStepperCollapsed(caption: "Nombre de personnes", icon: Image(packageResource: "numberOfMealsIcon", ofType: "png"))
//                { _ in }
                CoursesUFormRow(
                    caption: "Nombre de personnes",
                    icon: Image(packageResource: "numberOfMealsIcon", ofType: "png"),
                    content:
                        CoursesUStepper(defaultValue: numberGuests) { number in
                            print("number is \(number)")
                            numberGuests = number
//                            checkBudgetAndGuests()
//                            onBudgetChanged(BudgetInfos(moneyBudget: budget, numberOfGuests: numberGuests, numberOfMeals: numberMeals))
                        }

                )
                Divider()
                // TODO: localize
                CoursesUFormRow(
                    caption: "Nombre de repas",
                    icon: Image(packageResource: "numberOfPeopleIcon", ofType: "png"),
                    content:
                        CoursesUStepper(defaultValue: numberMeals, disableButton: !budgetAndGuestsValid) { number in numberMeals = number
                            
                        }

                )
                .addOpacity(!budgetAndGuestsValid)
                Divider()
                CoursesUButtonStyle(
                    backgroundColor: Color.primaryColor,
                    content: {
                        Button {
                            onFormValidated(BudgetInfos(moneyBudget: budget, numberOfGuests: numberGuests, numberOfMeals: numberMeals))
                        } label: {
                            HStack {
                                Image(packageResource: "searchIcon", ofType: "png")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text("C'est parti !")
                                    .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.bodyStyle)
                                    .foregroundColor(Color.white)
                            }
                        
                    }}, buttonAction: {
//                        onFormValidated(BudgetInfos(moneyBudget: budget, numberOfGuests: numberGuests, numberOfMeals: numberMeals))
                    })
            }
            .onChange(of: budgetAndGuestsValid) { isValid in
                    if isValid {
                        // fetch from api
                        print("Both budget and numberGuests are greater than 0!")
                    }
                }
            .padding(25)
            .background(Color.white)
            .cornerRadius(Dimension.sharedInstance.mCornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: Dimension.sharedInstance.mCornerRadius)
                    .stroke(Color.gray, lineWidth: 0.5)
            )
        }
    }
    
    
    
    @available(iOS 14, *)
    internal struct CoursesUStepper: View {
        @SwiftUI.State public var value: Int = 0
        let minValue: Int
        let maxValue: Int
        let disableButton: Bool
        public var onStepperChanged: (Int) -> Void
        let dimension = Dimension.sharedInstance
        init(defaultValue: Int = 0, minValue: Int = 0, maxValue: Int = 10, disableButton: Bool = false, onStepperChanged: @escaping (Int) -> Void) {
            _value = State(initialValue: defaultValue)
            self.minValue = minValue
            self.maxValue = maxValue
            self.disableButton = disableButton
            self.onStepperChanged = onStepperChanged
        }
        
        var maxButtonColor: Color {
            return (value >= maxValue || disableButton) ? Color.gray : Color.primaryColor
        }
        var minButtonColor: Color {
            return (value <= minValue || disableButton) ? Color.gray : Color.primaryColor
        }
        
        var body: some View {
            
                HStack(spacing: dimension.lPadding) {
                    Button(action: {
                        if value > minValue {
                            value -= 1
                            onStepperChanged(value)
                        }
                    }, label: {
                        Image(systemName: "minus")
//                            .resizable()
                            .foregroundColor(minButtonColor)
                            
                            .padding(dimension.sPadding)
                            .overlay(
                                Circle()
                                    .stroke(minButtonColor, lineWidth: 1)
                                    .frame(width: dimension.lButtonHeight, height: dimension.lButtonHeight)
                            )
                    })
                    .disabled(value <= minValue)
                    .disabled(disableButton)
                    Text("\(value)")
                        .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.bodyBigBoldStyle)
                    Button(action: {
                        if value < maxValue {
                            value += 1
                            onStepperChanged(value)
                        }
                    }, label: {
                        Image(systemName: "plus")
//                            .resizable()
                            .foregroundColor(maxButtonColor)
                            .padding(dimension.sPadding)
                            .overlay(
                                Circle()
                                    .stroke(maxButtonColor, lineWidth: 1)
                                    .frame(width: dimension.lButtonHeight, height: dimension.lButtonHeight)
                            )
                    })
                    .disabled(value >= maxValue)
                    .disabled(disableButton)
                }
                .padding(dimension.mPadding)
            
        }
    }
}
@available(iOS 14, *)
internal struct CoursesUFormRow<Content: View>: View {
    let caption: String?
    let icon: Image
    let content: Content
    init(
        caption: String? = nil,
        icon: Image,
        content: Content
    ) {
        self.content = content
        self.caption = caption
        self.icon = icon
    }
    let dimension = Dimension.sharedInstance
    var body: some View {
        HStack(spacing: Dimension.sharedInstance.sPadding) {
            icon
                .resizable()
                .frame(width: dimension.lButtonHeight, height: dimension.lButtonHeight)
                .padding(.horizontal, dimension.sPadding)
            
            
            if let caption = caption {
                HStack() {
                    Text(caption)
                        .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.bodyStyle)
                    Spacer()
                }
                    .frame(maxWidth: 100)
                Spacer()
            }
            
            content
            
            
        }
        .frame(height: 50)
    }
}

@available(iOS 14, *)
internal struct CoursesUTwoMealsBackground: View {
    var body: some View {
        VStack {
            Spacer()
            HStack() {
                Image(packageResource: "BudgetLeftSideBg", ofType: "png")
                Spacer()
                Image(packageResource: "BudgetRightSideBg", ofType: "png")
            }
        }
    }
}

@available(iOS 14, *)
struct CoursesUBudgetForm_Previews: PreviewProvider {
    
    
    static var previews: some View {
//        CoursesUBudgetForm().content(isFetchingRecipes: false, onBudgetChanged: { budgetInfos in
//            print("Budget changed: \(budgetInfos)")
//        }, onFormValidated: { _ in })
        
        CoursesUBudgetFormStandaloneWrapper()
        
        ZStack(alignment: .top) {
            Color.budgetBackgroundColor
            VStack(spacing: -40.0) {
                BudgetBackground()
//                CoursesUBudgetForm().content(isFetchingRecipes: false, onBudgetChanged: { budgetInfos in
//                    print("Budget changed: \(budgetInfos)")
//                }, onFormValidated: { _ in })
                CoursesUBudgetFormStandaloneWrapper()
                Spacer()
                    .frame(height: 80)
            }
            
        }
    }
    
}
