//
//  SwiftUIView.swift
//  
//
//  Created by didi on 6/12/23.
//

import SwiftUI

@available(iOS 14, *)
struct CoursesULikeButton: View {
    @State private var isHovered = false
       @State private var isSelected = false
        var onButtonPressed: () -> Void
    
        init(onButtonPressed: @escaping () -> Void) {
            self.onButtonPressed = onButtonPressed
        }

       var body: some View {
           Button(action: {
               self.isSelected.toggle()
               self.onButtonPressed()
           }) {
               Image(packageResource: imageName, ofType: "png")
                   .resizable()
                   .foregroundColor(.red)
                   .frame(width: 20, height: 20)
           }
           .padding(Dimension.sharedInstance.mPadding)
           .padding(.leading, imageName == "FilledHeartIcon" ? 2 : 1)
           .buttonStyle(PlainButtonStyle())
           .background(Circle().foregroundColor(.white))
           .onHover { hovering in
               self.isHovered = hovering
           }
       }

       private var imageName: String {
           if isSelected {
               return "FilledHeartIcon"
           } else {
               return "HeartWithPlusIcon"
           }
       }
}

@available(iOS 14, *)
struct CoursesULikeButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.budgetBackgroundColor
            CoursesULikeButton {
                print("pressed")
            }
        }
       
    }
}
