//
//  SwiftUIView.swift
//  
//
//  Created by didi on 6/5/23.
//

import SwiftUI

@available(iOS 14, *)
struct YellowSubtext: View {
    var text: String
    var body: some View {
        VStack(alignment: .leading, spacing: -6.0) {
            Text(text)
                .zIndex(1)
                .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.bodyBoldStyle)
            Image(packageResource: "YellowUnderline", ofType: "png")
                .resizable()
                .frame(width: 45, height: 8)
                .zIndex(0)
        }
        
    }
}

@available(iOS 14, *)
struct YellowSubtext_Previews: PreviewProvider {
    static var previews: some View {
        YellowSubtext(text: "14,96€")
    }
}
