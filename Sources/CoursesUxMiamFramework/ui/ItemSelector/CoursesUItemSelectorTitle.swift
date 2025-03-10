import mealzcore
import MealziOSSDK
import SwiftUI

@available(iOS 14, *)
public struct CoursesUItemSelectorTitle: BaseTitleProtocol {
    public init() {}
    public func content(params: TitleParameters) -> some View {
        HStack(spacing: 2) {
            Text(params.title.capitalizingFirstLetter() + " :")
                //.miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodyStyle)
                .coursesUFontStyle(style:
                    CoursesUFontStyleProvider.sharedInstance.bodyStyleMulish)
               
                .foregroundColor(Color.mealzColor(.standardDarkText))
            if let subtitle = params.subtitle {
                Text(subtitle)
                    .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodyBoldStyle)
                    .foregroundColor(Color.mealzColor(.primary))
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .background(Color.mealzColor(.lightBackground))
        .cornerRadius(Dimension.sharedInstance.mCornerRadius)
        .padding(Dimension.sharedInstance.mPadding)
    }
}
