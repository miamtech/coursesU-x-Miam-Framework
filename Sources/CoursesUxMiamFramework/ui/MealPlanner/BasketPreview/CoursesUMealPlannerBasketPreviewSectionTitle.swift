//
//  SwiftUIView.swift
//  
//
//  Created by didi on 6/22/23.
//

import SwiftUI
import miamCore
import MiamIOSFramework

@available(iOS 14, *)
public struct CoursesUMealPlannerBasketPreviewSectionTitle: BaseButtonProtocol {
    public init() {}
    public func content(params: BaseButtonParameters) -> some View {
        Button {
            withAnimation {
                params.onButtonAction()
            }
        } label: {
            HStack {
                Text(params.buttonText)
                    .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.subtitleStyle)
                Spacer()
                    Image(systemName: "chevron.up")
                        .resizable()
                        .foregroundColor(Color.black)
                        .frame(width: 16, height: 10)
                
            }
        }
        .padding(Dimension.sharedInstance.lPadding)
        .background(Color.lightGray)
        .cornerRadius(Dimension.sharedInstance.sCornerRadius)
        .padding(.horizontal, Dimension.sharedInstance.mPadding)
        .frame(maxWidth: .infinity)
    }
}

@available(iOS 14, *)
struct CoursesUMealPlannerBasketPreviewSectionTitle_Previews: PreviewProvider {
    static var previews: some View {
        CoursesUMealPlannerBasketPreviewSectionTitle()
            .content(params: BaseButtonParameters(buttonText: "Test", onButtonAction: {})) 
    }
}
