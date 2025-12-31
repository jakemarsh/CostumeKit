//
//  FontConvertible.swift
//  CostumeKit
//
//  Created by Jake Marsh on 9/28/16.
//  Copyright © 2016 Jake Marsh. All rights reserved.
//

#if canImport(UIKit)
import UIKit
public typealias PlatformFont = UIFont
#elseif canImport(AppKit)
import AppKit
public typealias PlatformFont = NSFont
#endif

/// A type that can be converted to a platform-specific font (UIFont or NSFont).
public protocol FontConvertible {
    /// The platform-specific font value.
    var fontValue: PlatformFont { get }
}

extension PlatformFont: FontConvertible {
    public var fontValue: PlatformFont { self }
}
