//
//  Costume.swift
//  CostumeKit
//
//  Created by Jake Marsh on 8/7/16.
//  Copyright © 2016 Jake Marsh. All rights reserved.
//

import Foundation

/// A protocol for defining app themes (costumes).
///
/// A Costume encapsulates all visual styling for your app, including colors,
/// fonts, and component styling methods. Implement this protocol to create
/// different themes that can be swapped at runtime.
///
/// Usage:
/// ```swift
/// class MyAppCostume: Costume {
///     let spacing: CGFloat = 8
///
///     func wearRootBackground(_ view: UIView) {
///         view.backgroundColor = MyAppColors.black.colorValue
///     }
///
///     func wearHeadline(_ label: UILabel) {
///         label.font = MyAppFont(size: .textStyle(.title1)).fontValue
///         label.textColor = MyAppColors.forestGreen.colorValue
///     }
///
///     var name: String { "Default" }
///     var description: String { "The default costume." }
///
///     init() { }
/// }
/// ```
public protocol Costume {
    /// The display name of the costume/theme.
    var name: String { get }

    /// A description of the costume/theme.
    var description: String { get }
}
