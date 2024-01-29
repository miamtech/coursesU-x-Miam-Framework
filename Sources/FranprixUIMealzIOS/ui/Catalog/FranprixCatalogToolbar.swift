//
//  FranprixCatalogToolbar .swift
//
//
//  Created by Diarmuid McGonagle on 29/01/2024.
//

import SwiftUI
import MiamIOSFramework

@available(iOS 14, *)
public struct FranprixCatalogToolbar: CatalogToolbarProtocol {
    public init () {}
    public func content(params: CatalogToolbarParameters) -> some View {
        
        HStack(spacing: Dimension.sharedInstance.xlPadding) {
            CatalogToolbarButtonFormat(icon:  Image(systemName: "magnifyingglass"), action: params.onSearchTapped)
            Spacer()
            CatalogToolbarButtonFormat(icon:  Image(systemName: "slider.horizontal.3"), action: params.onFiltersTapped)
//            if params.usesPreferences {
//                CatalogToolbarButtonFormat(icon:  Image.mealzIcon(icon: .chefHat), action: params.onPreferencesTapped)
//            }
//            CatalogToolbarButtonFormat(icon:  Image.mealzIcon(icon: .heart), action: params.onFavoritesTapped)
        }
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 16, trailing: 10))
        .background(Color.white)
    }
}

@available(iOS 14, *)
struct CatalogToolbarButtonFormat: View {
    let icon: Image
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            icon
                .renderingMode(.template)
                .foregroundColor(Color.mealzColor(.primary))
        }
        .frame(width: 40, height: 40)
        .background(Color.white).clipShape(Circle())
    }
}

@available(iOS 14, *)
struct FranprixCatalogToolbar_Previews: PreviewProvider {
    static var previews: some View {
        FranprixCatalogToolbar().content(
            params: CatalogToolbarParameters(
                usesPreferences: true,
                onFiltersTapped: {},
                onSearchTapped: {},
                onFavoritesTapped: {},
                onPreferencesTapped: {}))
    }
}
