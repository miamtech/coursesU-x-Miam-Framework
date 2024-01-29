//
//  SwiftUIView.swift
//  
//
//  Created by didi on 6/5/23.
//

import SwiftUI

@available(iOS 14, *)
struct RecapPriceForRecipes: View {
    var leadingText:String = ""
    var priceAmount:String
    // TODO: make this localized
    var trailingText:String = "le repas"
    var leadingPadding: CGFloat = 10
    var trailingPadding: CGFloat = 10
    var textFontStyle: CoursesUFontStyle = CoursesUFontStyleProvider.sharedInstance.bodyStyle
    var yellowSubtextFontStyle: CoursesUFontStyle = CoursesUFontStyleProvider.sharedInstance.bodyBigBoldStyle
    var yellowSubtextWidth: CGFloat = CGFloat(45)
    var body: some View {
        HStack(spacing: 3) {
            Text(leadingText)
                .foregroundColor(Color.black)
                .coursesUFontStyle(style: textFontStyle)
            YellowSubtext(text: priceAmount, fontStyle: yellowSubtextFontStyle, imageWidth: yellowSubtextWidth)
            Text(trailingText)
                .foregroundColor(Color.black)
                .coursesUFontStyle(style: textFontStyle)
        }
        .padding(.leading, leadingPadding)
        .padding(.trailing, trailingPadding)
        .padding(.vertical, 5)
        .frame(maxWidth: .infinity)
        .background(Color.recapTheRecipes)
        .cornerRadius(Dimension.sharedInstance.sCornerRadius)
        
        
    }
}

@available(iOS 14, *)
struct RecapPriceForRecipes_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading, spacing: 25) {
            RecapPriceForRecipes(priceAmount: "34.5€")
            RecapPriceForRecipes(leadingText: "Soit", priceAmount: "34.5€", leadingPadding: 20, trailingPadding: 20)
            RecapPriceForRecipes(priceAmount: "34.5€", trailingText: "le repas pour 4 personnes", trailingPadding: 50)
        }.padding()
        
    }
}
