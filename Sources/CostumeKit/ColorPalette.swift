//
//  ColorPalette.swift
//  CostumeKit
//
//  Created by Jake Marsh on 8/7/16.
//  Copyright © 2016 Jake Marsh. All rights reserved.
//

import Foundation

/// A protocol for defining color palettes using String raw values (hex codes).
///
/// Usage:
/// ```swift
/// public enum MyAppColors: String, ColorPalette {
///     case white = "FFFFFF"
///     case lightTeal = "3CB39E"
///     case forestGreen = "216055"
///     case black = "000000"
/// }
///
/// // Use the color
/// label.textColor = MyAppColors.forestGreen.colorValue
/// ```
public protocol ColorPalette: ColorConvertible {
    var rawValue: String { get }
}

public extension ColorPalette {
    var colorValue: PlatformColor {
        rawValue.colorValue
    }
}
