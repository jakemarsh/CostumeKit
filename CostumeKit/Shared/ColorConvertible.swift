//
//  ColorConvertible.swift
//  CostumeKit
//
//  Created by Jake Marsh on 9/28/16.
//  Copyright © 2016 Jake Marsh. All rights reserved.
//

import Foundation

#if os(iOS) || os(tvOS) || os(watchOS)
  import UIKit
  public typealias ColorType = UIColor
#elseif os(macOS)
  import Cocoa
  public typealias ColorType = NSColor
#endif

public protocol ColorConvertible {
  var colorValue: ColorType { get }
}

extension ColorConvertible {
  public func darkened(amount: Float = 0.4) -> ColorType {
    return self.colorValue // TODO: Darken
  }
}

#if os(iOS) || os(tvOS)
  extension UIColor : ColorConvertible {
    public var colorValue: ColorType { return self }
  }
#elseif os(macOS)
  extension NSColor : ColorConvertible {
    public var colorValue: NSColor { return self }
  }
#endif
