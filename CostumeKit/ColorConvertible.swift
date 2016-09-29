//
//  ColorConvertible.swift
//  CostumeKit
//
//  Created by Jake Marsh on 9/28/16.
//  Copyright © 2016 Jake Marsh. All rights reserved.
//

import Foundation

#if os(iOS)
  public typealias ColorType = UIColor
#elseif os(OSX)
  public typealias ColorType = NSColor
#endif

public protocol ColorConvertible {
  var colorValue: ColorType { get }
}

extension ColorConvertible {
  public func darkened(_: Float = 0.4) -> ColorType {
    return self.colorValue // TODO: Darken
  }
}

extension ColorType : ColorConvertible {
  public var colorValue: ColorType { return self }
}
