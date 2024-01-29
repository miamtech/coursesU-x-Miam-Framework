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
    var fontStyle : CoursesUFontStyle
    var imageWidth: CGFloat
    var imageHeight: CGFloat
    
    init(text: String, fontStyle: CoursesUFontStyle = CoursesUFontStyleProvider.sharedInstance.bodyBigBoldStyle, imageWidth: CGFloat = 45, imageHeight: CGFloat = 8) {
        self.text = text
        self.fontStyle = fontStyle
        self.imageWidth = imageWidth
        self.imageHeight = imageHeight
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: -6.0) {
            Text(text)
                .foregroundColor(Color.black)
                .zIndex(1)
                .coursesUFontStyle(style: fontStyle)
            Image(packageResource: "YellowUnderline", ofType: "png")
                .resizable()
                .frame(width: imageWidth, height: imageHeight)
                .zIndex(0)
        }
        
    }
}

@available(iOS 14, *)
struct YellowSubtext_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            YellowSubtext(text: "14,96€")
            YellowSubtext(text: "15,33", fontStyle: CoursesUFontStyleProvider.sharedInstance.titleBigStyle)
        }
    }
}
