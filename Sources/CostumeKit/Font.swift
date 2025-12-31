//
//  Font.swift
//  CostumeKit
//
//  Created by Jake Marsh on 8/7/16.
//  Copyright © 2016 Jake Marsh. All rights reserved.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

/// A protocol for defining custom fonts with dynamic type support.
///
/// Usage:
/// ```swift
/// public struct MyAppFont: Font {
///     public init(size: FontSize = .textStyle(.body)) {
///         self.size = size
///     }
///
///     public var size: FontSize
///
///     public var fontValue: UIFont {
///         UIFont(name: "SomeCustomFont", size: pointSize)!
///     }
/// }
/// ```
public protocol Font: FontConvertible {
    var size: FontSize { get set }
}

/// Represents a font size, either as a dynamic text style or a fixed point size.
public enum FontSize: Equatable, Sendable {
    #if canImport(UIKit)
    /// A dynamic text style that responds to the user's preferred content size.
    case textStyle(UIFont.TextStyle)
    #endif

    /// A fixed point size that can still adjust for accessibility settings.
    case fixed(CGFloat)
}

extension Font {
    /// The calculated point size based on the font size type and user's content size preferences.
    public var pointSize: CGFloat {
        switch size {
        #if canImport(UIKit)
        case .textStyle(let style):
            return UIFont.preferredFont(forTextStyle: style).pointSize
        #endif
        case .fixed(let ps):
            return ps + CGFloat(fixedSizeModifier)
        }
    }

    /// A modifier applied to fixed sizes based on the user's preferred content size.
    var fixedSizeModifier: Int {
        #if canImport(UIKit)
        let contentSize = UIApplication.shared.preferredContentSizeCategory

        switch contentSize {
        case .accessibilityExtraExtraExtraLarge: return 9
        case .accessibilityExtraExtraLarge: return 8
        case .accessibilityExtraLarge: return 7
        case .accessibilityLarge: return 6
        case .accessibilityMedium: return 5
        case .extraExtraExtraLarge: return 4
        case .extraExtraLarge: return 3
        case .extraLarge: return 2
        case .large: return 1
        case .medium: return 0
        case .small: return -1
        case .extraSmall: return -2
        default: return 0
        }
        #else
        return 0
        #endif
    }
}
