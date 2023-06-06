//
//  ButtonExtendedFunctionality.swift
//  MiamIOSFramework
//
//  Created by didi on 5/16/23.
//  Copyright © 2023 Miam. All rights reserved.
//

import SwiftUI

@available(iOS 14, *)
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
    @ViewBuilder func shadow() -> some View {
        self.shadow(radius: 3, x: 3, y: 3)
    }
    @ViewBuilder func addOpacity(_ needOpacity: Bool) -> some View {
        if needOpacity {
            self.opacity(0.5)
        } else {
            self
        }
    }
    @ViewBuilder func darkenView(_ darken: Bool) -> some View {
        if darken {
            self.brightness(-0.3)
        } else {
            self
        }
    }
}
