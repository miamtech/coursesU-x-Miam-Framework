import mealzcore
import MealziOSSDK
import SwiftUI

@available(iOS 14, *)
public struct CoursesUFiltersSection: FiltersSectionProtocol {
    public init() {}

    public func content(params: FiltersSectionParameters) -> some View {
        VStack {
            CoursesUToggleTitle(title: params.title, isExpanded: params.isExpanded, toggleIsExpanded: { withAnimation { params.isExpanded.toggle() } })
            if params.isExpanded {
                ForEach(params.filters, id: \.self) { filter in
                    CoursesURadioOrCheckButton(label: filter.uiLabel, isSelected: filter.isSelected, typeOfButton: params.typeOfInput, selectOption: {
                        params.onFilterSelected(filter)
                    })
                }
            }
        }
        .padding(.vertical, Dimension.sharedInstance.sPadding)
        .padding(.horizontal, Dimension.sharedInstance.lPadding)
    }
}

@available(iOS 14, *)
struct CoursesUToggleTitle: View {
    let title: String
    let isExpanded: Bool
    let toggleIsExpanded: () -> Void

    var body: some View {
        var degreeOfCaret: CGFloat = isExpanded ? -90 : 0
        return Button(action: toggleIsExpanded, label: {
            HStack {
                Text(title)
                    // .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.subtitleStyleMulish)
                    .coursesUFontStyle(style:
                        CoursesUFontStyleProvider.sharedInstance.subtitleStyleMulish)
                    .foregroundColor(Color.mealzColor(.darkestGray))
                Spacer()
                Image.mealzIcon(icon: .caret)
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.mealzColor(.primary))
                    .rotationEffect(Angle(degrees: degreeOfCaret))
            }
        })
        .padding(Dimension.sharedInstance.lPadding)
        .background(
            RoundedRectangle(cornerRadius: Dimension.sharedInstance.sCornerRadius)
                .foregroundColor(Color.mealzColor(.lightBackground))
        )
    }
}

@available(iOS 14, *)
public struct CoursesURadioOrCheckButton: View {
    let label: String
    let isSelected: Bool
    let typeOfButton: TypeOfInput
    let selectOption: () -> Void
    var backgroundColor: Color {
        return isSelected ? Color.mealzColor(.optionSelectedColor) : .clear
    }

    public var body: some View {
        HStack {
            Button(action: selectOption, label: {
                Text(label)
                    .foregroundColor(Color.mealzColor(.standardDarkText))
                    .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodyBigStyle)
                Spacer()
                Group {
                    if isSelected {
                        var icon: MealzIcons { isSelected ? .check : .plus }
                        Image.mealzIcon(icon: icon)
                            .renderingMode(.template)
                            .foregroundColor(Color.mealzColor(.white))
                    } else {
                        Rectangle().foregroundColor(.clear)
                    }
                }
                .frame(width: 22, height: 22)
                .background(
                    Group {
                        if typeOfButton == .checkbox {
                            AnyView(
                                RoundedRectangle(cornerRadius: Dimension.sharedInstance.buttonCornerRadius)
                                    .fill(backgroundColor)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: Dimension.sharedInstance.buttonCornerRadius)
                                            .stroke(Color.mealzColor(.lightGray), lineWidth: 1.0)
                                    )
                            )
                        } else {
                            AnyView(
                                Circle()
                                    .fill(backgroundColor)
                                    .overlay(Circle().stroke(Color.mealzColor(.lightGray)))
                            )
                        }
                    }
                )

            })
            .frame(maxWidth: .infinity)
        }
        .padding(Dimension.sharedInstance.sPadding)
    }
}
