//
//  SwiftUIView.swift
//  
//
//  Created by didi on 6/24/23.
//

import SwiftUI
import MiamIOSFramework

@available(iOS 14, *)
public struct CoursesUMealPlannerBasketPreviewLoading: LoadingProtocol {
    public init() {}
    public func content(params: BaseLoadingParameters) -> some View {
        ProgressLoader(color: Color.primaryColor)
    }
}
