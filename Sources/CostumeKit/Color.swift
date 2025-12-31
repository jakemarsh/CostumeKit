//
//  Color.swift
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

/// A String-based color type that can be initialized with hex values.
///
/// Usage:
/// ```swift
/// public enum MyAppColors: String, ColorPalette {
///     case white = "FFFFFF"
///     case lightTeal = "3CB39E"
///     case forestGreen = "216055"
///     case black = "000000"
/// }
/// ```
public typealias Color = String

extension Color: ColorConvertible {
    public var colorValue: PlatformColor {
        PlatformColor(hexString: self) ?? .clear
    }

    public static let none = PlatformColor.clear
    public static let white = PlatformColor.white
    public static let black = PlatformColor.black
}

// MARK: - Hex Color Parsing

private extension Int {
    func duplicate4bits() -> Int {
        (self << 4) + self
    }
}

/// An extension of UIColor (on iOS) or NSColor (on macOS) providing HEX color handling.
public extension PlatformColor {
    /// Create a color with the given hex string. Alpha will be set to 1.0 by default.
    /// - Parameter hexString: The hex string, with or without the hash character (e.g., "FF0000" or "#FF0000").
    convenience init?(hexString: String) {
        self.init(hexString: hexString, alpha: 1.0)
    }

    /// Create a color with the given hex string and alpha.
    /// - Parameters:
    ///   - hexString: The hex string, with or without the hash character.
    ///   - alpha: The alpha value, a floating value between 0 and 1.
    convenience init?(hexString: String, alpha: CGFloat) {
        var hex = hexString

        // Remove hash if present
        if hex.hasPrefix("#") {
            hex = String(hex.dropFirst())
        }

        guard let hexVal = Int(hex, radix: 16) else {
            return nil
        }

        switch hex.count {
        case 3:
            self.init(hex3: hexVal, alpha: alpha)
        case 6:
            self.init(hex6: hexVal, alpha: alpha)
        default:
            return nil
        }
    }

    /// Create a color with the given hex value. Alpha will be set to 1.0 by default.
    /// - Parameter hex: The hex value. For example: 0xff8942 (no quotation).
    convenience init?(hex: Int) {
        self.init(hex: hex, alpha: 1.0)
    }

    /// Create a color with the given hex value and alpha.
    /// - Parameters:
    ///   - hex: The hex value. For example: 0xff8942 (no quotation).
    ///   - alpha: The alpha value, a floating value between 0 and 1.
    convenience init?(hex: Int, alpha: CGFloat) {
        guard (0x000000...0xFFFFFF).contains(hex) else {
            return nil
        }
        self.init(hex6: hex, alpha: alpha)
    }

    private convenience init(hex3: Int, alpha: CGFloat) {
        self.init(
            red: CGFloat(((hex3 & 0xF00) >> 8).duplicate4bits()) / 255.0,
            green: CGFloat(((hex3 & 0x0F0) >> 4).duplicate4bits()) / 255.0,
            blue: CGFloat(((hex3 & 0x00F) >> 0).duplicate4bits()) / 255.0,
            alpha: alpha
        )
    }

    private convenience init(hex6: Int, alpha: CGFloat) {
        self.init(
            red: CGFloat((hex6 & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex6 & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat((hex6 & 0x0000FF) >> 0) / 255.0,
            alpha: alpha
        )
    }

    /// Returns the hex string representation of the color.
    var hexString: String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        #if canImport(UIKit)
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        #elseif canImport(AppKit)
        usingColorSpace(.sRGB)?.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        #endif

        let r = Int(red * 255)
        let g = Int(green * 255)
        let b = Int(blue * 255)

        return String(format: "%02X%02X%02X", r, g, b)
    }
}
