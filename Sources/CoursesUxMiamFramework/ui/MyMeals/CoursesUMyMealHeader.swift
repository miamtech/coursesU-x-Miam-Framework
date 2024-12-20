//
//  CoursesUMyMealHeader.swift
//  CoursesUxMiamFramework
//
//  Created by Damien Walerowicz on 17/12/2024.
//

import Foundation
import mealzcore
import MealziOSSDK
import SwiftUI

@available(iOS 14, *)
public struct CoursesUMyMealHeader: BaseHeaderProtocol {
    public init() {}
    public func content(
        params: BaseHeaderParameters
    ) -> some View {
        VStack(spacing: 0) {
            ZStack(alignment: .center) {
                Text(params.title)
                    .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.titleStyle)
                    .foregroundColor(Color.mealzColor(.white))
                HStack {
                    Button(action: params.goBack, label: {
                        Image.mealzIcon(icon: .arrow)
                            .renderingMode(.template)
                            .rotationEffect(Angle(degrees: 180))
                    }).frame(width: 40, height: 40)
                        .overlay(Circle().stroke(Color.white, lineWidth: 1))
                        .foregroundColor(Color.mealzColor(.white))
                        .clipShape(Circle()).padding()
                    Spacer()
                }.frame(maxWidth: .infinity)
            }
            .background(Color.mealzColor(.primary))
            Divider().frame(maxWidth: .infinity)
        }
    }
}
