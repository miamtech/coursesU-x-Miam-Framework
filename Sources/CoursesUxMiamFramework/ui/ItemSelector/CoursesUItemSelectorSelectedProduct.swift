import mealzcore
import MealziOSSDK
import SwiftUI

@available(iOS 14, *)
public struct CoursesUItemSelectorSelectedProduct: ItemSelectorSelectedProductProtocol {
    public init() {}

    public func content(params: ItemSelectorSelectedProductParameters) -> some View {
        CoursesUItemSelectorProductRow(product: params.product, isSelected: true)
            .onTapGesture {
                params.onSeeItemDetails(params.product.id)
            }
    }
}

@available(iOS 14, *)
public struct CoursesUItemSelectorOptionProducts: ItemSelectorOptionProductsProtocol {
    public init() {}

    public func content(params: ItemSelectorOptionProductsParameters) -> some View {
        ForEach(params.products, id: \.self) { product in
            HStack {
                CoursesUItemSelectorProductRow(
                    product: product,
                    isASubstitution: params.isASubstitution,
                    onSelectProduct: params.onItemSelected
                )
            }.onTapGesture {
                params.onSeeItemDetails(product.id)
            }
        }
    }
}

@available(iOS 14, *)
struct CoursesUItemSelectorProductRow: View {
    private var isSelected: Bool
    private var isASubstitution: Bool
    private var product: Item
    private var onSelectProduct: ((Item) -> Void)?

    init(
        product: Item,
        isSelected: Bool = false,
        isASubstitution: Bool = false,
        onSelectProduct: ((Item) -> Void)? = nil
    ) {
        self.isSelected = isSelected
        self.isASubstitution = isASubstitution
        self.product = product
        self.onSelectProduct = onSelectProduct
    }

    var body: some View {
        return VStack(spacing: 0) {
            VStack {
                if let discountType = product.attributes?.discountType,
                   discountType != DiscountType.unsupported && discountType != DiscountType.undiscounted
                {
                    if let discountAmount = product.attributes?.discountAmount {
                        discountTopTag(discountAmount: discountAmount.doubleValue, discountType: product.attributes!.discountType!)
                    }
                }
                HStack {
                    if let picture = URL(string: product.attributes?.image ?? "") {
                        AsyncImage(url: picture) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        }
                        .frame(width: 90, height: 90)
                        .clipped()
                    } else {
                        Image.mealzIcon(icon: .pan).frame(width: 90, height: 90)
                    }
                    VStack(alignment: .leading) {
                        Text(product.attributes?.brand ?? "")
                            .coursesUFontStyle(style:
                                CoursesUFontStyleProvider.sharedInstance.bodySmallBoldStyleMulish)
                            .padding(.bottom, 8)
                        Text(product.attributes?.name ?? "")
                            .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodySmallBoldStyle)
                        IngredientUnitBubble(capacity: product.capacityCombined)
                        Text(product.pricePerUnitOfMeasurementAsString)
                            .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodySmallStyle)
                            .foregroundColor(Color.mealzColor(.grayText))
                        Spacer()
                    }.padding(16)
                    Spacer()
                }
                HStack {
                    if let unitPrice = product.attributes?.unitPrice {
                        CoursesUItemSelectorProductRow.productPrice(
                            formattedProductPrice: Double(unitPrice).currencyFormatted,
                            discountType: product.attributes?.discountType ?? DiscountType.unsupported,
                            discountedPrice: product.attributes?.discountedPrice?.doubleValue
                        )
                    }
                    Spacer()
                    Button(action: {
                        if let onSelectProduct {
                            onSelectProduct(product)
                        }
                    }, label: {
                        Text(
                            isSelected ? Localization.itemSelector.inBasket.localised
                            : isASubstitution ? Localization.itemSelector.replace.localised
                            : Localization.itemSelector.add.localised
                        )
                            .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodyMediumBoldStyle)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 9)
                            .foregroundColor(isSelected ? Color.mealzColor(.grayText) : Color.mealzColor(.white))
                            .background(isSelected ? Color.mealzColor(.lightBackground) : Color.mealzColor(.primary))
                            .cornerRadius(Dimension.sharedInstance.buttonCornerRadius)
                    })
                }
            }
            .padding([.horizontal, .bottom], Dimension.sharedInstance.lPadding)
            .background(
                isSelected ? Color.mealzColor(.itemSelectedBackground) : Color.clear
            )
            Divider()
        }
    }

    @ViewBuilder
    public static func productPrice(
        formattedProductPrice: String,
        discountType: DiscountType,
        discountedPrice: Double? = nil
    ) -> some View {
        VStack(alignment: .leading) {
            if discountType != DiscountType.unsupported && discountType != DiscountType.undiscounted {
                Text(formattedProductPrice)
                    .strikethrough(color: Color.mealzColor(.primaryText))
                    // .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.bodyStyle)
                    .coursesUFontStyle(style:
                        CoursesUFontStyleProvider.sharedInstance.bodyStyleMulish)
                    .foregroundColor(Color.mealzColor(.primaryText))

                if let discountedPrice {
                    Text(discountedPrice.currencyFormatted)
                        // .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.titleStyle)
                        .coursesUFontStyle(style:
                            CoursesUFontStyleProvider.sharedInstance.titleStyleMulish)
                        .foregroundColor(Color.mealzColor(.primaryText))
                }
            } else {
                Text(formattedProductPrice)
                    // .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.titleStyle)
                    .coursesUFontStyle(style:
                        CoursesUFontStyleProvider.sharedInstance.titleStyleMulish)
                    .foregroundColor(Color.mealzColor(.primaryText))
            }
        }
    }
}
