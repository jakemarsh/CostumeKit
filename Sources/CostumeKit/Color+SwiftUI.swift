//
//  Color+SwiftUI.swift
//  CostumeKit
//
//  SwiftUI Color integration for ColorConvertible types.
//

import SwiftUI

extension ColorConvertible {
    /// Converts this color to a SwiftUI Color.
    ///
    /// Usage:
    /// ```swift
    /// enum MyColors: String, ColorPalette {
    ///     case primary = "3CB39E"
    /// }
    ///
    /// Text("Hello")
    ///     .foregroundColor(MyColors.primary.swiftUIColor)
    /// ```
    public var swiftUIColor: SwiftUI.Color {
        SwiftUI.Color(colorValue)
    }
}

extension SwiftUI.Color {
    /// Creates a SwiftUI Color from a hex string.
    ///
    /// Usage:
    /// ```swift
    /// Color(hex: "3CB39E")
    /// Color(hex: "#FF0000")
    /// ```
    public init?(hex: String) {
        guard let platformColor = PlatformColor(hexString: hex) else {
            return nil
        }
        self.init(platformColor)
    }

    /// Creates a SwiftUI Color from a hex integer.
    ///
    /// Usage:
    /// ```swift
    /// Color(hex: 0x3CB39E)
    /// ```
    public init?(hex: Int) {
        guard let platformColor = PlatformColor(hex: hex) else {
            return nil
        }
        self.init(platformColor)
    }
}
