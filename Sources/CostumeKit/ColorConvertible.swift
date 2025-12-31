//
//  ColorConvertible.swift
//  CostumeKit
//
//  Created by Jake Marsh on 9/28/16.
//  Copyright © 2016 Jake Marsh. All rights reserved.
//

#if canImport(UIKit)
import UIKit
public typealias PlatformColor = UIColor
#elseif canImport(AppKit)
import AppKit
public typealias PlatformColor = NSColor
#endif

/// A type that can be converted to a platform-specific color (UIColor or NSColor).
public protocol ColorConvertible {
    /// The platform-specific color value.
    var colorValue: PlatformColor { get }
}

extension ColorConvertible {
    /// Returns a darkened version of the color.
    /// - Parameter amount: The amount to darken (0.0 to 1.0). Default is 0.4.
    /// - Returns: A darkened color.
    public func darkened(amount: CGFloat = 0.4) -> PlatformColor {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0

        #if canImport(UIKit)
        colorValue.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        #elseif canImport(AppKit)
        colorValue.usingColorSpace(.sRGB)?.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        #endif

        return PlatformColor(
            hue: hue,
            saturation: saturation,
            brightness: max(brightness - amount, 0),
            alpha: alpha
        )
    }

    /// Returns a lightened version of the color.
    /// - Parameter amount: The amount to lighten (0.0 to 1.0). Default is 0.4.
    /// - Returns: A lightened color.
    public func lightened(amount: CGFloat = 0.4) -> PlatformColor {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0

        #if canImport(UIKit)
        colorValue.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        #elseif canImport(AppKit)
        colorValue.usingColorSpace(.sRGB)?.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        #endif

        return PlatformColor(
            hue: hue,
            saturation: saturation,
            brightness: min(brightness + amount, 1),
            alpha: alpha
        )
    }
}

extension PlatformColor: ColorConvertible {
    public var colorValue: PlatformColor { self }
}
