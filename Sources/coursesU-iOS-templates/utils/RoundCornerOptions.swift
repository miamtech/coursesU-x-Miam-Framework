//
//  RoundCornerOptions.swift
//  MiamIOSFramework
//
//  Created by didi on 5/23/23.
//  Copyright © 2023 Miam. All rights reserved.
//

import SwiftUI

@available(iOS 14, *)
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

extension UIRectCorner {
    static var top: UIRectCorner {
        return [.topLeft, .topRight]
    }
    static var bottom: UIRectCorner {
        return [.bottomLeft, .bottomRight]
    }
    static var right: UIRectCorner {
        return [.topRight, .bottomRight]
    }
    static var left: UIRectCorner {
        return [.topLeft, .bottomLeft]
    }
}

@available(iOS 14, *)
struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
