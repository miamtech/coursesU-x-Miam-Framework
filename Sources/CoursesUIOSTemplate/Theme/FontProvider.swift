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
    var font: Font = Font.system(size: 24, weight: .bold, design: .default)
    var color: Color?
}

@available(iOS 14, *)
public struct TitleFontStyle: CoursesUFontStyle {
    var font: Font = Font.system(size: 20, weight: .semibold, design: .default)
    var color: Color?
}

@available(iOS 14, *)
public struct TitleMediumFontStyle: CoursesUFontStyle {
    var font: Font = Font.system(size: 16, weight: .semibold, design: .default)
    var color: Color?
}

@available(iOS 14, *)
public struct TitleSmallFontStyle: CoursesUFontStyle {
    var font: Font = Font.system(size: 14, weight: .semibold, design: .default)
    var color: Color?
}

@available(iOS 14, *)
public struct TitleExtraSmallFontStyle: CoursesUFontStyle {
    var font: Font = Font.system(size: 13, weight: .semibold, design: .default)
    var color: Color?
}

@available(iOS 14, *)
public struct TitleExtraSmallMediumFontStyle: CoursesUFontStyle {
    var font: Font = Font.system(size: 13, weight: .medium, design: .default)
    var color: Color?
}

@available(iOS 14, *)
public struct SubtitleFontStyle: CoursesUFontStyle {
    var font: Font = Font.system(size: 15, weight: .bold, design: .default)
    var color: Color?
}

@available(iOS 14, *)
public struct BodyBigFontStyle: CoursesUFontStyle {
    var font: Font = Font.system(size: 16, design: .default)
    var color: Color?
}

@available(iOS 14, *)
public struct BodyBigBoldFontStyle: CoursesUFontStyle {
    var font: Font = Font.system(size: 16, weight: .bold, design: .default)
    var color: Color?
}

@available(iOS 14, *)
public struct BodyBigLightFontStyle: CoursesUFontStyle {
    var font: Font = Font.system(size: 16, weight: .light, design: .default)
    var color: Color?
}

@available(iOS 14, *)
public struct BodyFontStyle: CoursesUFontStyle {
    var font: Font = Font.system(size: 15, design: .default)
    var color: Color?
}

@available(iOS 14, *)
public struct BodyBoldFontStyle: CoursesUFontStyle {
    var font: Font = Font.system(size: 15, weight: .bold, design: .default)
    var color: Color?
}

@available(iOS 14, *)
public struct BodyMediumFontStyle: CoursesUFontStyle {
    var font: Font = Font.system(size: 14, design: .default)
    var color: Color?
}

@available(iOS 14, *)
public struct BodyMediumBoldFontStyle: CoursesUFontStyle {
    var font: Font = Font.system(size: 14, weight: .bold, design: .default)
    var color: Color?
}

@available(iOS 14, *)
public struct BodySmallFontStyle: CoursesUFontStyle {
    var font: Font = Font.system(size: 12, design: .default)
    var color: Color?
}

@available(iOS 14, *)
public struct BodySmallBoldFontStyle: CoursesUFontStyle {
    var font: Font = Font.system(size: 12, weight: .bold, design: .default)
    var color: Color?
}

@available(iOS 14, *)
public struct BodyExtraSmallFontStyle: CoursesUFontStyle {
    var font: Font = Font.system(size: 11, design: .default)
    var color: Color?
}

@available(iOS 14, *)
public struct CoursesUFontStyleProvider {
    static let sharedInstance = CoursesUFontStyleProvider()

    public var titleStyle = TitleFontStyle()
    public var titleBigStyle = TitleBigFontStyle()
    public var titleMediumStyle = TitleMediumFontStyle()
    public var titleSmallStyle = TitleSmallFontStyle()
    public var titleExtraSmallStyle = TitleExtraSmallFontStyle()
    public var titleExtraSmallMediumStyle = TitleExtraSmallMediumFontStyle()
    public var subtitleStyle = SubtitleFontStyle()
    public var bodyStyle = BodyFontStyle()
    public var bodyBigStyle = BodyBigFontStyle()
    public var bodyBigLightStyle = BodyBigLightFontStyle()
    public var bodyBigBoldStyle = BodyBigBoldFontStyle()
    public var bodyBoldStyle = BodyBoldFontStyle()
    public var bodyMediumStyle = BodyMediumFontStyle()
    public var bodyMediumBoldStyle = BodyMediumBoldFontStyle()
    public var bodySmallStyle = BodySmallFontStyle()
    public var bodySmallBoldStyle = BodySmallBoldFontStyle()
    public var bodyExtraSmallStyle = BodyExtraSmallFontStyle()
}
