//
//  SwiftUIView.swift
//  
//
//  Created by didi on 6/24/23.
//

import SwiftUI

@available(iOS 14, *)
public struct NoSearchResults: View {
    var message: String
    public var body: some View {
        HStack {
            Image(systemName: "exclamationmark")
                .resizable()
                .foregroundColor(Color.danger)
                .frame(width: 5, height: 25)
                .padding(.trailing, Dimension.sharedInstance.lPadding)
            Text(message)
                .coursesUFontStyle(style: CoursesUFontStyleProvider().bodyBigStyle)
        }
        .padding(.vertical, Dimension.sharedInstance.lPadding)
        .padding(.horizontal, Dimension.sharedInstance.xlPadding)
        .background(Color.dangerBackground)
        .cornerRadius(Dimension.sharedInstance.mCornerRadius)
    }
}
