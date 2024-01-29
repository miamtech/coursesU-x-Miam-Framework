//
//  File.swift
//  
//
//  Created by didi on 6/7/23.
//

import Foundation
import SwiftUI

// quick util function to remove lines between lists 
@available(iOS 14, *)
struct removeLines: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 15, *) {
            content
                .listRowSeparator(.hidden)
        } else {
            content
        }
        
    }
}
