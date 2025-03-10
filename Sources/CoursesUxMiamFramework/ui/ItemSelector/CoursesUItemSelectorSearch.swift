import mealzcore
import MealziOSSDK
import SwiftUI

@available(iOS 14, *)
public struct CoursesUItemSelectorSearch: SearchProtocol {
    public init() {}
    public func content(params: SearchParameters) -> some View {
        HStack(alignment: .center, spacing: 8) {
            Image.mealzIcon(icon: .search)
                .renderingMode(.template)
                .frame(width: 24, height: 24)
                .foregroundColor(Color.mealzColor(.grayText))
            TextField(
                params.placeHolderText ?? Localization.itemSelector.search.localised,
                text: params.searchText)
                .coursesUFontStyle(style:
                    CoursesUFontStyleProvider.sharedInstance.bodyMediumBoldStyleMulish)
                .foregroundColor(params.searchText.wrappedValue.isEmpty ? Color.mealzColor(.standardDarkText) : Color.mealzColor(.grayText))
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .onChange(of: params.searchText.wrappedValue, perform: { _ in
                    params.onApply()
                })
        }
        .padding(Dimension.sharedInstance.mPadding)
        .overlay(RoundedRectangle(cornerRadius: Dimension.sharedInstance.mCornerRadius)
            .stroke(Color.mealzColor(.border), lineWidth: 1.0))
        .padding(Dimension.sharedInstance.mPadding)
    }
}
