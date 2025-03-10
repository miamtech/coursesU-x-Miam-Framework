import SwiftUI

import mealzcore
import MealziOSSDK

@available(iOS 14, *)
public struct CoursesURecipeDetailsSponsor: RecipeDetailsSponsorProtocol {
    public init() {}
    public func content(params: RecipeDetailsSponsorParameters) -> some View {
        HStack(spacing: 0.0) {
            VStack(alignment: .leading, spacing: 8.0) {
                Text(Localization.sponsorBanner.sponsorBannerSpeach.localised)
                    // .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodyStyle)
                    .coursesUFontStyle(style:
                        CoursesUFontStyleProvider.sharedInstance.bodyStyleMulish)

                Button {
                    params.onSponsorTapped()
                } label: {
                    Text(Localization.sponsorBanner.sponsorBannerMoreInfo.localised)
                        .coursesUFontStyle(style:
                            CoursesUFontStyleProvider.sharedInstance.bodyStyleMulish)
                }
            }
            Spacer(minLength: 16.0)
            if let sponsorAttributes = params.sponsor.attributes, let logoURL = URL(string: sponsorAttributes.logoUrl) {
                AsyncImage(url: logoURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 75.0, height: 48.0)
            }
        }
        .padding(Dimension.sharedInstance.mPadding)
    }
}
