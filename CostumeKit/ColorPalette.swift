//
//  ColorPalette.swift
//  CostumeKit
//
//  Created by Jake Marsh on 8/7/16.
//  Copyright © 2016 Jake Marsh. All rights reserved.
//

import Foundation

public protocol ColorPalette : ColorConvertible {
  var rawValue: String { get }
}

public extension ColorPalette {
  var colorValue: UIColor { return rawValue.colorValue }
}
