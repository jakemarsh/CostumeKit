//
//  SVG.swift
//  CostumeKit
//
//  Created by Jake Marsh on 8/7/16.
//  Copyright © 2016 Jake Marsh. All rights reserved.
//

import Foundation
import CoreGraphics

public protocol SVG {
  func metadata() -> SVGMetadata
}

public struct SVGMetadata {
  public let name: String
  public let size: CGSize
  public let fullColor: Bool

  public init(name: String, size: CGSize, fullColor: Bool = true) {
    self.name = name
    self.size = size
    self.fullColor = fullColor
  }
}
