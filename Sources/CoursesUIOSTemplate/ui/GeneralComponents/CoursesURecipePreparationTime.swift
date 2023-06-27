//
//  SwiftUIView.swift
//  
//
//  Created by didi on 6/27/23.
//

import SwiftUI

@available(iOS 14, *)
public struct CoursesURecipePreparationTime: View {
    let duration: String

    public init(duration: String) {
        self.duration = duration
    }

    public var body: some View {
        VStack {
            Image(packageResource: "TimerIcon", ofType: "png")
                .resizable()
                .frame(width: 25, height: 25)
            Text(duration)
                .coursesUFontStyle(style: CoursesUFontStyleProvider().bodyStyle)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
        }
    }
}

@available(iOS 14, *)
struct CoursesURecipePreparationTime_Previews: PreviewProvider {
    static var previews: some View {
        CoursesURecipePreparationTime(duration: "10 min")
    }
}
