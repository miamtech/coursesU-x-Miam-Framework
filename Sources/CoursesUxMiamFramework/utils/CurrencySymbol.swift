//
//  File.swift
//  
//
//  Created by didi on 6/7/23.
//

import Foundation

func currencySymbol(forCurrencyCode code: String) -> String? {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencyCode = code
    return formatter.currencySymbol
}
