//
//  CoursesUGeneralSearch.swift
//
//
//  Created by didi on 21/09/2023.
//

import mealzcore
import MealziOSSDK
import SwiftUI

@available(iOS 14, *)
public struct CoursesUGeneralSearch: SearchProtocol {
    private let hasButton: Bool
    public init(hasButton: Bool = true) {
        self.hasButton = hasButton
    }

    public func content(params: SearchParameters) -> some View {
        var longerThanThreeChars: Bool {
            return params.searchText.wrappedValue.count > 2
        }
        return VStack(spacing: 10.0) {
            HStack(spacing: 10.0) {
                HStack(spacing: 10.0) {
                    TextField(Localization.catalog.searchTitle.localised, text: params.searchText)
                        .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.bodyMediumBoldStyleMulish)
                        .frame(height: 45.0)
                        .disableAutocorrection(true)
                    if hasButton {
                        Button {
                            params.onApply()
                        } label: {
                            Image.mealzIcon(icon: .search)
                                .renderingMode(.template)
                                .foregroundColor(Color.mealzColor(.white))
                                .padding(10)
                                .background(longerThanThreeChars ? Color.mealzColor(.primary) : Color.mealzColor(.primary)).clipShape(Circle())
                                .shadow(radius: 2.0)
                        }
                        // .darkenView(!longerThanThreeChars)
                        .disabled(!longerThanThreeChars)
                    }
                }
                .padding([.leading], 16).frame(height: 45.0)
                .padding([.trailing], 2)
                .overlay(Capsule().stroke(Color.gray, lineWidth: 1.0))
            }.padding(10)
            Spacer()
        }
    }
}

@available(iOS 14, *)
struct CoursesUGeneralSearch_Previews: PreviewProvider {
    static var previews: some View {
        CoursesUGeneralSearch().content(params: SearchParameters(
            searchText: .constant(""),
            onApply: {}))
    }
}
