//
//  Font.swift
//  iosApp
//
//  Created by didi on 1/13/23.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import SwiftUI
//
//  CoursesUFontStyle.swift
//  CoursesUIOSFramework
//
//  Created by Vincent Kergonna on 25/11/2022.
//  Copyright © 2022 CoursesU. All rights reserved.
//

import Foundation
import SwiftUI

@available(iOS 14, *)

protocol CoursesUFontStyle {
    var font: Font { get }
    var color: Color? { get }
}

@available(iOS 14, *)
struct CoursesUFontStyleModifier: ViewModifier {
    let fontStyle: CoursesUFontStyle

    func body(content: Content) -> some View {
        if let color = fontStyle.color {
                    content.font(fontStyle.font).foregroundColor(color)
                } else {
                    content.font(fontStyle.font)
                }
    }
}

@available(iOS 14, *)
extension View {
    func coursesUFontStyle(style: any CoursesUFontStyle) -> some View {
        modifier(CoursesUFontStyleModifier(fontStyle: style))
    }
}

