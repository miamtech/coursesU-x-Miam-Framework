////
////  SwiftUIView.swift
////  
////
////  Created by didi on 7/5/23.
////
//
//import SwiftUI
//import miamCore
//import MiamIOSFramework
//
//@available(iOS 14, *)
//struct CoursesURecipeCardDetailsModal: View {
//    @SwiftUI.State private var showBasketPreview: Bool = false
//    @SwiftUI.State private var showItemSelector: Bool = false
//    @SwiftUI.State private var showSponsorDetail: Bool = false
//    @SwiftUI.State private var sponsor: Sponsor? = nil
//    
//    
//
//    var body: some View {
//        
//        var pricePerPerson: Double {
//            return price.price / Double(recipeViewModel.guest)
//        }
//        return ZStack {
//            VStack {
//                RecipeDetailsView(
//                    vmRecipe: recipeViewModel,
//                    showFooter: false,
//                    showCounter: true,
//                    showMealIdeaImage: false,
//                    sponsorDetailsTapped: { sponsor in
//                        self.sponsor = sponsor
//                        self.showSponsorDetail = true
//                    },
//                    close: {
//                        close()
//                    }, navigateToPreview: {},
//                    buy: {}
//                )
//                if recipeViewModel.sortedSteps.count == 0 {
//                    ProgressLoader(color: Color.primaryColor)
//                }
//            }
//            VStack {
//                Spacer()
////                CoursesURecipeDetailsFooter(pricePerPerson: pricePerPerson, priceForMeal: price.formattedPrice())
//            }
//        }
//        .ignoresSafeArea()
//    }
//}
//
//@available(iOS 14, *)
//struct CoursesURecipeCardDetailsModal_Previews: PreviewProvider {
//    static var previews: some View {
//        CoursesURecipeCardDetailsModal().content(recipeId: "", price: Price(price: 21.2, currency: "EUR"), recipeViewModel: RecipeCardVM(routerVM: RouterOutletViewModel()), close: {})
//    }
//}
