//
//  SwiftUIView.swift
//  
//
//  Created by didi on 6/5/23.
//

import SwiftUI

@available(iOS 14, *)
struct YellowOffCenterNumber: View {
    var number: String
    var body: some View {
        Text(number).coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.subtitleStyle)
            .padding(Dimension.sharedInstance.lPadding)
            .background(Color.numberOfRecipes)
            .cornerRadius(Dimension.sharedInstance.sCornerRadius)
            .rotationEffect(.degrees(-2.44))
            
    }
}

@available(iOS 14, *)
struct YellowOffCenterNumber_Previews: PreviewProvider {
    static var previews: some View {
        YellowOffCenterNumber(number: "4")
    }
}
