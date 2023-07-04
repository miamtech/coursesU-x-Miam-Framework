//
//  File.swift
//  
//
//  Created by didi on 6/5/23.
//

import UIKit
import SwiftUI
//
//@available(iOS 13, *)
//extension Image {
//    init(packageResource name: String, ofType type: String) {
//        #if canImport(UIKit)
//        guard let path = Bundle.main.path(forResource: name, ofType: type),
//              let image = UIImage(contentsOfFile: path) else {
//            self.init(name)
//            return
//        }
//        self.init(uiImage: image)
//        #elseif canImport(AppKit)
//        guard let path = Bundle.main.path(forResource: name, ofType: type),
//              let image = NSImage(contentsOfFile: path) else {
//            self.init(name)
//            return
//        }
//        self.init(nsImage: image)
//        #else
//        self.init(name)
//        #endif
//    }
//}

class ImageBuilder:Any { } // Necessary for UIImage extension below
extension UIImage {
    convenience init?(fromPodAssetName name: String) {
        let bundle = Bundle(for: ImageBuilder.self)
        self.init(named: name, in: bundle, compatibleWith: nil)
    }
}

@available(iOS 13, *)
extension Image {
    init(packageResource name: String, ofType type: String) {
        #if canImport(UIKit)
        #if SWIFT_PACKAGE
        guard let path = Bundle.module.path(forResource: name, ofType: type),
              let image = UIImage(contentsOfFile: path) else {
            self.init(name)
            return
        }
        #else
        let bundle = Bundle(for: ImageBuilder.self)
        guard let path = bundle.path(forResource: name, ofType: type),
              let image = UIImage(contentsOfFile: path) else {
            self.init(name)
            return
        }
        #endif
        self.init(uiImage: image)
        #elseif canImport(AppKit)
        #if SWIFT_PACKAGE
        guard let path = Bundle.module.path(forResource: name, ofType: type),
              let image = NSImage(contentsOfFile: path) else {
            self.init(name)
            return
        }
        #else
        let bundle = Bundle(for: ImageBuilder.self)
        guard let path = bundle.path(forResource: name, ofType: type),
              let image = NSImage(contentsOfFile: path) else {
            self.init(name)
            return
        }
        #endif
        self.init(nsImage: image)
        #else
        self.init(name)
        #endif
    }
}
