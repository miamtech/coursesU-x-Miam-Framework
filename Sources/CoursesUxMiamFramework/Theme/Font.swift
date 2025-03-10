//
//  Font.swift
//  iosApp
//
//  Created by didi on 1/13/23.
//  Copyright © 2023 orgName. All rights reserved.
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

extension UIFont {
    static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) -> Bool {
        guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension) else {
            fatalError("Couldn't find font \(fontName)")
        }

        guard let fontDataProvider = CGDataProvider(url: fontURL as CFURL) else {
            fatalError("Couldn't load data from the font \(fontName)")
        }

        guard let font = CGFont(fontDataProvider) else {
            fatalError("Couldn't create font from data")
        }

        var error: Unmanaged<CFError>?
        let success = CTFontManagerRegisterGraphicsFont(font, &error)
        guard success else {
            print("Error registering font: maybe it was already registered.")
            return false
        }

        return true
    }

    public static func registerMulish() {
        let myBundle = Bundle(for: CoursesUxMiamFrameworkClass.self)

        _ = UIFont.registerFont(bundle: myBundle, fontName: "Mulish-Bold", fontExtension: "ttf")
        _ = UIFont.registerFont(bundle: myBundle, fontName: "Mulish-Black", fontExtension: "ttf")
        _ = UIFont.registerFont(bundle: myBundle, fontName: "Mulish-Medium", fontExtension: "ttf")
        _ = UIFont.registerFont(bundle: myBundle, fontName: "Mulish-Regular", fontExtension: "ttf")
    }
}
