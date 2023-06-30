//
//  SwiftUIView.swift
//  
//
//  Created by didi on 6/6/23.
//

import SwiftUI
import miamCore
import MiamIOSFramework

// just used for preview 
@available(iOS 14, *)
public struct CoursesUBudgetFormStandaloneWrapper: View {
    @SwiftUI.State var budgetInfos = BudgetInfos(moneyBudget: 0.0, numberOfGuests: 0, numberOfMeals: 0)
    
    public init() {}
    public var body: some View {
        CoursesUMealPlannerForm().content(budgetInfos: $budgetInfos, isFetchingRecipes: false, onFormValidated: {_ in})
    }
}

@available(iOS 14, *)
public struct CoursesUMealPlannerForm: MealPlannerForm {
    var includeTitle: Bool
    var includeLogo: Bool
    var includeBackground: Bool
    let dimension = Dimension.sharedInstance
    public init(includeTitle: Bool = true, includeLogo: Bool = true, includeBackground: Bool = true) {
        self.includeTitle = includeTitle
        self.includeLogo = includeLogo
        self.includeBackground = includeBackground
    }
    
    
    
    public func content(budgetInfos: Binding<BudgetInfos>, isFetchingRecipes: Bool, onFormValidated: @escaping (BudgetInfos) -> Void) -> some View {
        var budgetAndGuestsValid: Bool {
//            return false
            return budgetInfos.wrappedValue.moneyBudget > 0.0 && budgetInfos.wrappedValue.numberOfGuests > 0
        }
        var colorOfSubmit: Color {
            if budgetAndGuestsValid && budgetInfos.wrappedValue.numberOfMeals > 0 {
                return Color.primaryColor
            } else { return Color.lightGray }
        }
        return ZStack(alignment: .top) {
            if includeBackground {
                Color.white
                CoursesUTwoMealsBackground()
            }
            VStack {
                if includeLogo {
                    Image(uiImage: UIImage(fromPodAssetName: "BudgetRepasLogo") ?? UIImage())
                        .resizable()
                        .padding(.horizontal, 50)
                        .frame(width: UIScreen.screenWidth, height: 100)
                        .padding(.top)
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
                        icon: Image(uiImage: UIImage(fromPodAssetName: "BudgetIcon") ?? UIImage()),
                        content:
                            HStack {
                                Spacer()
                                CoursesUInputWithCurrency(budget: budgetInfos.moneyBudget)
                            }
                            .padding(dimension.mPadding)
                        
                    )
                    Divider()
                    // TODO: localize
                    //                CoursesUStepperCollapsed(caption: "Nombre de personnes", icon: Image(uiImage: UIImage(fromPodAssetName: "numberOfMealsIcon")?? UIImage())))
                    //                { _ in }
                    CoursesUFormRow(
                        caption: "Nombre de personnes",
                        icon: Image(uiImage: UIImage(fromPodAssetName: "numberOfMealsIcon") ?? UIImage()),
                        content:
                            //                        Text("hello")
                        CoursesUStepper(value: budgetInfos.numberOfGuests)
                        
                    )
                    Divider()
                    // TODO: localize
                    CoursesUFormRow(
                        caption: "Nombre de repas",
                        icon: Image(uiImage: UIImage(fromPodAssetName: "numberOfPeopleIcon") ?? UIImage()),
                        content:
                            //                        Text("hello")
                        CoursesUStepper(value: budgetInfos.numberOfMeals, maxValue: budgetInfos.wrappedValue.maxRecipesForBudget, disableButton: !budgetAndGuestsValid)
                        
                    )
                    .addOpacity(!budgetAndGuestsValid)
                    Divider()
                    CoursesUButtonStyle(
                        backgroundColor: colorOfSubmit,
                        content: {
                            Button {
                                onFormValidated(budgetInfos.wrappedValue)
                            } label: {
                                HStack {
                                    Image(uiImage: UIImage(fromPodAssetName: "searchIcon") ?? UIImage())
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                    Text("C'est parti !")
                                        .foregroundColor(Color.white)
                                        .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.bodyStyle)
                                        
                                }
                                
                            }
                            .disabled(!budgetAndGuestsValid || !(budgetInfos.wrappedValue.numberOfMeals > 0))
                        }, buttonAction: {
                        })
                    
                }
                .padding(25)
                .background(Color.white)
                .cornerRadius(Dimension.sharedInstance.mCornerRadius)
                .overlay(
                    RoundedRectangle(cornerRadius: Dimension.sharedInstance.mCornerRadius)
                        .stroke(Color.gray, lineWidth: 0.5)
                )
                .padding(includeLogo ? dimension.mPadding : 0)
            }
        }
    }
    
    
    
    @available(iOS 14, *)
    internal struct CoursesUStepper: View {
        @Binding var value: Int
        let minValue: Int
        let maxValue: Int
        let disableButton: Bool
        let dimension = Dimension.sharedInstance
        init(value: Binding<Int>, minValue: Int = 0, maxValue: Int = 99, disableButton: Bool = false) {
            _value = value
            self.minValue = minValue
            self.maxValue = maxValue
            self.disableButton = disableButton
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
                Image(uiImage: UIImage(fromPodAssetName: "BudgetLeftSideBg") ?? UIImage())
                Spacer()
                Image(uiImage: UIImage(fromPodAssetName: "BudgetRightSideBg") ?? UIImage())
            }
        }
    }
}

@available(iOS 14, *)
struct CoursesUBudgetForm_Previews: PreviewProvider {
    
    
    
    static var previews: some View {
        BudgetFormPreview()
    }
    
    struct BudgetFormPreview: View {
        
        @SwiftUI.State var budgetInfoss = BudgetInfos(moneyBudget: 40.0, numberOfGuests: 3, numberOfMeals: 2)
        var body: some View {
            CoursesUBudgetFormStandaloneWrapper()
            
            ZStack(alignment: .top) {
                Color.budgetBackgroundColor
                VStack(spacing: -40.0) {
                    MealPlannerBackground()
                    CoursesUBudgetFormStandaloneWrapper()
                    Spacer()
                        .frame(height: 80)
                }
                
            }
        }
    }
    
}
