//
//  UIStateWrapperView.swift
//  MiamIOSFramework
//
//  Created by Vincent Kergonna on 26/05/2023.
//  Copyright © 2023 Miam. All rights reserved.
//
import SwiftUI
import miamCore
import MiamIOSFramework

@available(iOS 14, *)
struct UIStateWrapperView<State: AnyObject, Success: View, Loading: View, Empty: View>: View {
    let uiState: BasicUiState<State>?
    @ViewBuilder let loadingView: Loading
    @ViewBuilder let emptyView: Empty
    @ViewBuilder let successView: Success

    var body: some View {
        switch self.uiState {
        case is BasicUiStateEmpty:
            emptyView
        case is BasicUiStateError:
            if let error = Template.sharedInstance.errorTemplate {
                error()
            } else {
                HStack { } // TODO handle error state
            }
        case is BasicUiStateSuccess<State>:
            successView
        case is BasicUiStateLoading:
            loadingView
        default:
            VStack {
                // Generic error, unknown state, should not happen.
            }
        }
    }
}
