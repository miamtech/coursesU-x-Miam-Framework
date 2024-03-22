//
//  CoursesUfiltersView.swift
//  CoursesUxMiamFramework
//
//  Created by Damien Walerowicz on 20/03/2024.
//

import Foundation
import MiamIOSFramework
import SwiftUI


@available(iOS 14.0, *)
public struct CoursesUFilterView: FiltersHeaderProtocol {
    public init() {}
    public func content(params: FiltersHeaderParameters) -> some View  {
        HStack {
            Text(Localization.catalog.filtersTitle.localised)
                .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.titleMediumStyle)
            Spacer()
        }.padding([.top], 20)
    }
    
}
