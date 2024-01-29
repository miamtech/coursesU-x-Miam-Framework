//
//  SwiftUIView.swift
//  
//
//  Created by didi on 6/6/23.
//

import SwiftUI
@available (iOS 14, *)

struct CoursesUButtonStyle<Content: View>: View {
    let backgroundColor: Color
    let buttonStrokeColor: Color
    let cornerRadius: CGFloat
    let content: () -> Content
    let buttonAction: () -> Void
    init(backgroundColor: Color,
         buttonStrokeColor: Color = Color.clear,
         cornerRadius: CGFloat = Dimension.sharedInstance.xlCornerRadius,
         content: @escaping () -> Content,
         buttonAction: @escaping () -> Void
    ) {
        self.backgroundColor = backgroundColor
        self.buttonStrokeColor = buttonStrokeColor
        self.cornerRadius = cornerRadius
        self.content = content
        self.buttonAction = buttonAction
    }
    var body: some View {
        VStack {
            Button {
                withAnimation {
                    buttonAction()
                }
            } label: {
                content()
            }
//            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            .padding(.vertical, 15)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .overlay(RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(buttonStrokeColor, lineWidth: 1.0)
            )
        }
    }
}
@available(iOS 14, *)
struct CoursesUButtonStyle_Previews: PreviewProvider {
    struct ContentView: View {
        @State private var isLoading = false

        var body: some View {
            let primColor = Color.primaryColor
            let white =  Color.white

            return VStack {
                CoursesUButtonStyle(
                    backgroundColor: primColor,
                    content: { Text("Standard").foregroundColor(white) },
                    buttonAction: { print("I was pressed") }
                )
                CoursesUButtonStyle(
                    backgroundColor: white,
                    buttonStrokeColor: primColor,
                    content: { Text("Change Color").foregroundColor(primColor) },
                    buttonAction: { print("I was pressed") }
                )
                CoursesUButtonStyle(
                    backgroundColor: primColor,
                    cornerRadius: CGFloat(5),
                    content: { Text("Change Radius").foregroundColor(white) },
                    buttonAction: { print("I was pressed") }
                )
//                CoursesUButtonStyle(
//                    backgroundColor: primColor,
//                    cornerRadius: CGFloat(5),
//                    content: {
//                        VStack {
//                            if isLoading {
//                                ProgressLoader(color: .white)
//                                    .scaleEffect(0.5)
//                            } else {
//                                Text("Show progress loader")
//                                    .miamFontStyle(style: MiamFontStyleProvider.sharedInstance.titleStyle)
//                                    .foregroundColor(white)
//                            }
//                        }
//                    },
//                    buttonAction: { isLoading.toggle() }
//                )
            }
            .padding()
        }
    }

    static var previews: some View {
        ContentView()
    }
}
