//
//  File.swift
//  
//
//  Created by didi on 28/07/2023.
//

import Foundation
import MiamIOSFramework

extension Price {
    public func formattedPriceTrailing() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency

        // Set the positive format with the currency code on the trailing side
        numberFormatter.positiveFormat = "#,##0.00 ¤"

        numberFormatter.currencyCode = self.currency

        return numberFormatter.string(from: NSDecimalNumber(floatLiteral: price)) ?? ""
    }

}
