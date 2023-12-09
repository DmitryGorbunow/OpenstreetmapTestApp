//
//  СommonСonstants.swift
//  OpenstreetmapTestApp
//
//  Created by Dmitry Gorbunow on 12/9/23.
//

import UIKit

enum Offsets {
    static var s: CGFloat { 8 }
    static var m: CGFloat { 10 }
    static var l: CGFloat { 16 }
    static var xl: CGFloat { 32 }
    static var xxl: CGFloat { 64 }
}

enum CornerRadius {
    static var l: CGFloat { 20 }
}

enum BorderWidth {
    static var s: CGFloat { 2.0 }
}

enum Fonts {
    static let s = UIFont.systemFont(ofSize: 10, weight: .light)
    static let sB = UIFont.systemFont(ofSize: 10, weight: .bold)
    static let m = UIFont.systemFont(ofSize: 16, weight: .light)
    static let mB = UIFont.systemFont(ofSize: 16, weight: .bold)
}

enum Sizes {
    static var divider: CGFloat { 2 }
    static var dividerM: CGFloat { 3 }
    static var multiplierS: CGFloat { 0.22 }
    static var multiplier: CGFloat { 0.8 }
    static var l: CGFloat { 40 }
    static var xl: CGFloat { 45 }
    static var xxl: CGFloat { 80 }
}

enum StringValues: String {
    case annotationViewIdentifier = "custom"
}
