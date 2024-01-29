//
//  FranprixFavoritesTitle.swift
//
//
//  Created by Diarmuid McGonagle on 29/01/2024.
//

import SwiftUI
import MiamIOSFramework

/* pass
 self.observers.invoke {
     $0.showRecipesCatalog(self)
 }
 for showCatalog
 */

@available(iOS 14, *)
public struct FranprixFavoritesTitle: BaseTitleProtocol {
    private let showCatalog: () -> Void
    public init(showCatalog: @escaping () -> Void) {
        self.showCatalog = showCatalog
    }
    public func content(params: TitleParameters) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(params.title)
//                    .font(.lexend(.semiBold, 16))
//                    .foregroundColor(Color.F.black)
                    .foregroundColor(Color.mealzColor(.darkestGray))
                Spacer()
                if let subtitle = params.subtitle {
                    Button {
                        showCatalog()
                    } label: {
                        Text(subtitle)
                            .foregroundColor(Color.mealzColor(.primary))
                        //                        .foregroundColor(Color.F.orange)
                        //                        .font(.lexend(.medium, 14))
                    }
                }
            }
            Text("Gagnez du temps : retrouvez ici vos recettes favorites 🍜")
//                .font(.lexend(.medium, 12))
//                .foregroundColor(Color.F.grey1)
                .foregroundColor(Color.mealzColor(.lighterGray))
                .lineLimit(2)
        }.padding(.horizontal, 20.0)
    }
}

@available(iOS 14, *)
struct FranprixFavoritesTitle_Previews: PreviewProvider {
    static var previews: some View {
        FranprixFavoritesTitle(showCatalog: {}).content(params: TitleParameters(
            title: Localization.favorites.title.localised,
            subtitle: Localization.favorites.goToCatalog.localised))
    }
}
