import mealzcore
import MealziOSSDK
import SwiftUI

@available(iOS 14, *)
public struct CoursesUDefaultHeaderCentered: BaseHeaderProtocol {
    public init() {}
    public func content(
        params: BaseHeaderParameters
    ) -> some View {
        VStack(spacing: 0) {
            ZStack(alignment: .center) {
                Text(params.title)
                    // .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.titleStyle)
                    .coursesUFontStyle(style:
                        CoursesUFontStyleProvider.sharedInstance.titleStyleMulish)
                    .foregroundColor(Color.mealzColor(.standardDarkText))
                    .padding(Dimension.sharedInstance.mPadding)
                HStack {
                    goBackButton(goBack: params.goBack)
                    Spacer()
                }.frame(maxWidth: .infinity)
            }.padding(Dimension.sharedInstance.lPadding)
            Divider().frame(maxWidth: .infinity)
        }
    }
}

@available(iOS 14, *)
@ViewBuilder
func goBackButton(goBack: @escaping () -> Void) -> some View {
    Button(action: goBack, label: {
        Image.mealzIcon(icon: .arrow)
            .resizable()
            .frame(width: 15, height: 15)
            .rotationEffect(.degrees(180))
            .padding(Dimension.sharedInstance.mPadding)
            .background(
                RoundedRectangle(
                    cornerRadius: Dimension.sharedInstance.buttonCornerRadius
                )
                .fill(Color.mealzColor(.lightBackground))
            )
    })
}
