//
//  MiamBudgetPlannerLoading.swift
//  MiamIOSFramework
//
//  Created by Vincent Kergonna on 26/04/2023.
//  Copyright © 2023 Miam. All rights reserved.
//

import SwiftUI
import miamCore
import MiamIOSFramework

@available(iOS 14, *)
public struct CoursesUMealPlannerLoading: LoadingProtocol {
    public init() {}
    public func content(params: BaseLoadingParameters) -> some View {
        Text("loading")
    }
}
