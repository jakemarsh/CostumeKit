//
//  Font+SwiftUI.swift
//  CostumeKit
//
//  SwiftUI Font integration for FontConvertible types.
//

import SwiftUI

extension FontConvertible {
    /// Converts this font to a SwiftUI Font.
    ///
    /// Usage:
    /// ```swift
    /// let myFont = SystemFont(size: .textStyle(.title1), weight: .bold)
    ///
    /// Text("Hello")
    ///     .font(myFont.swiftUIFont)
    /// ```
    public var swiftUIFont: SwiftUI.Font {
        SwiftUI.Font(fontValue)
    }
}

#if canImport(UIKit)
import UIKit

extension FontSize {
    /// Converts this FontSize to a SwiftUI Font.TextStyle if applicable.
    public var swiftUITextStyle: SwiftUI.Font.TextStyle? {
        switch self {
        case .textStyle(let style):
            switch style {
            case .largeTitle: return .largeTitle
            case .title1: return .title
            case .title2: return .title2
            case .title3: return .title3
            case .headline: return .headline
            case .subheadline: return .subheadline
            case .body: return .body
            case .callout: return .callout
            case .footnote: return .footnote
            case .caption1: return .caption
            case .caption2: return .caption2
            default: return nil
            }
        case .fixed:
            return nil
        }
    }
}
#endif
