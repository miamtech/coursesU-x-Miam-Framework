//
//  File.swift
//
//
//  Created by didi on 6/5/23.
//

import Foundation
import SwiftUI

@available(iOS 14, *)
public struct TitleBigFontStyle: CoursesUFontStyle {
    var font: Font = .system(size: 24, weight: .bold, design: .default)
    var color: Color? = Color.black
}

@available(iOS 14, *)
public struct TitleBigFontStyleMulish: CoursesUFontStyle {
    var font: Font = .custom("Mulish-Bold", size: 24)
    var color: Color? = Color.black
}

@available(iOS 14, *)
public struct TitleFontStyle: CoursesUFontStyle {
    var font: Font = .system(size: 20, weight: .semibold, design: .default)
    var color: Color? = Color.black
}

@available(iOS 14, *)
public struct TitleFontStyleMulish: CoursesUFontStyle {
    var font: Font = .custom("Mulish-Bold", size: 20)
    var color: Color? = Color.black
}

@available(iOS 14, *)
public struct TitleMediumFontStyle: CoursesUFontStyle {
    var font: Font = .system(size: 16, weight: .semibold, design: .default)
    var color: Color? = Color.black
}

@available(iOS 14, *)
public struct TitleMediumFontStyleMulish: CoursesUFontStyle {
    var font: Font = .custom("Mulish-Bold", size: 16)
    var color: Color? = Color.black
}

@available(iOS 14, *)
public struct SubtitleFontStyle: CoursesUFontStyle {
    var font: Font = .system(size: 15, weight: .bold, design: .default)
    var color: Color? = Color.black
}

@available(iOS 14, *)
public struct SubtitleFontStyleMulish: CoursesUFontStyle {
    var font: Font = .custom("Mulish-Bold", size: 15)
    var color: Color? = Color.black
}

@available(iOS 14, *)
public struct BodyBigFontStyle: CoursesUFontStyle {
    var font: Font = .system(size: 16, design: .default)
    var color: Color? = Color.black
}

@available(iOS 14, *)
public struct BodyBigFontStyleMulish: CoursesUFontStyle {
    var font: Font = .custom("Mulish-Regular", size: 16)
    var color: Color? = Color.black
}

@available(iOS 14, *)
public struct BodyBigBoldFontStyle: CoursesUFontStyle {
    var font: Font = .system(size: 16, weight: .bold, design: .default)
    var color: Color? = Color.black
}

@available(iOS 14, *)
public struct BodyBigBoldFontStyleMulish: CoursesUFontStyle {
    var font: Font = .custom("Mulish-Bold", size: 16)
    var color: Color?
}

@available(iOS 14, *)
public struct BodyFontStyle: CoursesUFontStyle {
    var font: Font = .system(size: 15, design: .default)
//    var color: Color?
    var color: Color? = Color.black
}

@available(iOS 14, *)
public struct BodyFontStyleMulish: CoursesUFontStyle {
    var font: Font = .custom("Mulish-Regular", size: 15)
    var color: Color?
}

@available(iOS 14, *)
public struct BodyBoldFontStyle: CoursesUFontStyle {
    var font: Font = .system(size: 15, weight: .bold, design: .default)
//    var color: Color?
    var color: Color? = Color.black
}

@available(iOS 14, *)
public struct BodyBoldFontStyleMulish: CoursesUFontStyle {
    var font: Font = .custom("Mulish-Bold", size: 15)
    var color: Color? = Color.black
}

@available(iOS 14, *)
public struct BodyMediumBoldFontStyle: CoursesUFontStyle {
    var font: Font = .system(size: 14, weight: .bold, design: .default)
    var color: Color? = Color.black
}

@available(iOS 14, *)
public struct BodyMediumBoldFontStyleMulish: CoursesUFontStyle {
    var font: Font = .custom("Mulish-Bold", size: 14)
    var color: Color? = Color.black
}

@available(iOS 14, *)
public struct BodySmallFontStyle: CoursesUFontStyle {
    var font: Font = .system(size: 10, design: .default)
    var color: Color? = Color.gray
}

@available(iOS 14, *)
public struct BodySmallFontStyleMulish: CoursesUFontStyle {
    var font: Font = .custom("Mulish-Regular", size: 10)
    var color: Color? = Color.gray
}

@available(iOS 14, *)
public struct BodySmallBoldFontStyle: CoursesUFontStyle {
    var font: Font = .system(size: 12, weight: .bold, design: .default)
    var color: Color? = Color.black
}

@available(iOS 14, *)
public struct BodySmallBoldFontStyleMulish: CoursesUFontStyle {
    var font: Font = .custom("Mulish-Bold", size: 12)
    var color: Color? = Color.black
}

@available(iOS 14, *)
public struct CoursesUFontStyleProvider {
    static let sharedInstance = CoursesUFontStyleProvider()

    public var titleStyle = TitleFontStyle()
    public var titleBigStyle = TitleBigFontStyle()
    public var titleMediumStyle = TitleMediumFontStyle()

    public var subtitleStyle = SubtitleFontStyle()
    public var bodyStyle = BodyFontStyle()
    public var bodyBigStyle = BodyBigFontStyle()

    public var bodyBigBoldStyle = BodyBigBoldFontStyle()
    public var bodyBoldStyle = BodyBoldFontStyle()

    public var bodyMediumBoldStyle = BodyMediumBoldFontStyle()
    public var bodySmallStyle = BodySmallFontStyle()
    public var bodySmallBoldStyle = BodySmallBoldFontStyle()

    public var titleStyleMulish = TitleFontStyleMulish()
    public var titleBigStyleMulish = TitleBigFontStyleMulish()
    public var titleMediumStyleMulish = TitleMediumFontStyleMulish()

    public var subtitleStyleMulish = SubtitleFontStyleMulish()
    public var bodyStyleMulish = BodyFontStyleMulish()
    public var bodyBigStyleMulish = BodyBigFontStyleMulish()

    public var bodyBigBoldStyleMulish = BodyBigBoldFontStyleMulish()
    public var bodyBoldStyleMulish = BodyBoldFontStyleMulish()

    public var bodyMediumBoldStyleMulish = BodyMediumBoldFontStyleMulish()
    public var bodySmallStyleMulish = BodySmallFontStyleMulish()
    public var bodySmallBoldStyleMulish = BodySmallBoldFontStyleMulish()
}
