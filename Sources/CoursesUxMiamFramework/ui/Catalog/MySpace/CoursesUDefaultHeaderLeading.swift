import mealzcore
import MealziOSSDK
import SwiftUI

@available(iOS 14, *)
public struct CoursesUDefaultHeaderLeading: BaseHeaderProtocol {
    public init() {}
    public func content(
        params: BaseHeaderParameters
    ) -> some View {
        HStack {
            goBackButton(goBack: params.goBack)
            Text(params.title)
                //.miamFontStyle(style: MiamFontStyleProvider.sharedInstance.titleStyle)
                .coursesUFontStyle(style: CoursesUFontStyleProvider.sharedInstance.titleStyleMulish)
                .foregroundColor(Color.mealzColor(.standardDarkText))
                .padding(Dimension.sharedInstance.mPadding)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, Dimension.sharedInstance.lPadding)
        .padding(.top, Dimension.sharedInstance.mPadding)
    }
}
