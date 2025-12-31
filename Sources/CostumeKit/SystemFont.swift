//
//  SystemFont.swift
//  CostumeKit
//
//  Created by Jake Marsh on 8/17/16.
//  Copyright © 2016 Jake Marsh. All rights reserved.
//

#if canImport(UIKit)
import UIKit

/// A system font implementation with dynamic type support.
///
/// Usage:
/// ```swift
/// let bodyFont = SystemFont(size: .textStyle(.body))
/// let boldTitle = SystemFont(size: .textStyle(.title1), weight: .bold)
/// let fixedSize = SystemFont(size: .fixed(14), weight: .medium)
/// ```
public struct SystemFont: Font {
    /// The font weight.
    public var weight: UIFont.Weight

    /// The font size specification.
    public var size: FontSize

    /// Creates a new system font.
    /// - Parameters:
    ///   - size: The font size. Default is `.textStyle(.body)`.
    ///   - weight: The font weight. Default is `.regular`.
    public init(size: FontSize = .textStyle(.body), weight: UIFont.Weight = .regular) {
        self.size = size
        self.weight = weight
    }

    public var fontValue: UIFont {
        .systemFont(ofSize: pointSize, weight: weight)
    }
}

#elseif canImport(AppKit)
import AppKit

/// A system font implementation for macOS.
public struct SystemFont: Font {
    /// The font weight.
    public var weight: NSFont.Weight

    /// The font size specification.
    public var size: FontSize

    /// Creates a new system font.
    /// - Parameters:
    ///   - size: The font size. Default is `.fixed(13)`.
    ///   - weight: The font weight. Default is `.regular`.
    public init(size: FontSize = .fixed(13), weight: NSFont.Weight = .regular) {
        self.size = size
        self.weight = weight
    }

    public var fontValue: NSFont {
        .systemFont(ofSize: pointSize, weight: weight)
    }
}
#endif
