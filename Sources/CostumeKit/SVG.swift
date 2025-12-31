//
//  SVG.swift
//  CostumeKit
//
//  Created by Jake Marsh on 8/7/16.
//  Copyright © 2016 Jake Marsh. All rights reserved.
//

import Foundation
#if canImport(CoreGraphics)
import CoreGraphics
#endif

/// A protocol for defining SVG assets with metadata.
///
/// Usage:
/// ```swift
/// enum MyAppSVGs: SVG {
///     case clockGlyph
///     case bird
///
///     func metadata() -> SVGMetadata {
///         switch self {
///         case .clockGlyph:
///             return SVGMetadata(name: "clock", size: CGSize(width: 100, height: 100), fullColor: false)
///         case .bird:
///             return SVGMetadata(name: "bird", size: CGSize(width: 58, height: 28), fullColor: true)
///         }
///     }
/// }
/// ```
public protocol SVG {
    /// Returns the metadata for this SVG asset.
    func metadata() -> SVGMetadata
}

/// Metadata describing an SVG asset.
public struct SVGMetadata: Equatable, Sendable {
    /// The name of the SVG file (without extension).
    public let name: String

    /// The intrinsic size of the SVG.
    public let size: CGSize

    /// Whether the SVG should be rendered in full color or as a template.
    public let fullColor: Bool

    /// Creates SVG metadata.
    /// - Parameters:
    ///   - name: The name of the SVG file.
    ///   - size: The intrinsic size of the SVG.
    ///   - fullColor: Whether to render in full color. Default is `true`.
    public init(name: String, size: CGSize, fullColor: Bool = true) {
        self.name = name
        self.size = size
        self.fullColor = fullColor
    }
}
