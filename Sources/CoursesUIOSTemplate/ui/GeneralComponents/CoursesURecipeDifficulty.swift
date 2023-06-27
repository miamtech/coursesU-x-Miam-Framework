//
//  File.swift
//  
//
//  Created by didi on 6/27/23.
//
import SwiftUI
import miamCore

@available(iOS 14, *)
public struct CoursesURecipeDifficulty: View {
    let difficulty: Int

    public init(difficulty: Int) {
        self.difficulty = difficulty
    }

    public var body: some View {
        VStack {
            HStack(spacing: 0) {
                ForEach(0..<difficulty, id: \.self) { item in
                    Image(packageResource: "ChefHatIcon", ofType: "png")
                        .resizable()
                        .frame(width: 25, height: 25)
                }
            }
            Text(difficultyDescription)
                .coursesUFontStyle(style: CoursesUFontStyleProvider().bodyStyle)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
        }
    }

    var difficultyDescription: String {

        switch difficulty {
        case 1: return "Débutant"
        case 2: return "Avancé"
        default: return "Confirmé"
        }
    }
}

@available(iOS 14, *)
struct CoursesURecipeDifficulty_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            CoursesURecipeDifficulty(difficulty: 1)
            CoursesURecipeDifficulty(difficulty: 2)
            CoursesURecipeDifficulty(difficulty: 3)
        }
        
    }
}
