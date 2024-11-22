//
//  CoursesULoadingView.swift
//  
//
//  Created by Diarmuid McGonagle on 25/01/2024.
//

import Foundation
import mealzcore
import MealziOSSDK
import SwiftUI

@available(iOS 14, *)
public struct CoursesULoadingView: LoadingProtocol {
    public init() {}
    public func content(params: BaseLoadingParameters) -> some View {
        ProgressLoader(color: Color.mealzColor(.primary))
    }
}
